require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'logger'
require 'optparse'
require 'tag_info.rb'

class DiskCrawler
  attr_accessor :processor

  def initialize(processor)
    @processor = processor
  end

  def scan(top_dir)
    if not File.exist?(top_dir)
      raise "#{top_dir} does not exist!"
    else
      craw(top_dir)
    end
  end
  
  def craw(node)
    if File.directory?(node)
      puts "Dir: #{node}"
      Dir.new(node).each do |name|
        if name !~ /^\./ #no hidden, no current, no parent directories
          path = "#{node}/#{name}"
          craw(path)
        end
      end
    else #file
      @processor.process(node)
    end
  end
end

class Mp3Processor
  include TagInfo

  def initialize(logger)
    @log = logger
  end
  
  #Extract mp3 tags and store in DB
  def process(file)
    if file =~ /\.mp3$/
      begin
        tag = tag_of(file)

        if tag.title.blank?
          tag.title = File.base_name(file, '.mp3')
        end

        tag.delete_if{|key, val| not (TagInfo::USEFULL_TAGS.include?(key))} #only take valid tag
        tag[:location] = file

        song = Song.new(tag)
        song.save!
      rescue Exception=>e
        @log.error(e) #and silently continue
      end
    end
  end
end

class WMAProcessor
  def process(file)
    if file =~ /\.wma$/
        puts file
    end
  end
end

if $0 == __FILE__
  options = {}
  optparse = OptionParser.new do|opts|
    opts.banner = "Usage: build_song_lib.rb [-h | -d directory]"
    # Define the options, and what they do
    options[:dir] = nil
    opts.on( '-d path_to_song_collection',"Specify the top directory of your song collection" ) do |d|
      options[:dir] = d
    end
    
    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end
  # Parse the command-line. Remember there are two forms of the parse method.
  # The 'parse' method simply parses ARGV, while the 'parse!' method parses ARGV and removes any options found there,
  # as well as any parameters for the options. What's left is the list of files to resize.
  optparse.parse!
  begin
    if options[:dir] != nil
      log = Logger.new("#{Rails.root}/log/song_craw.log")
      robot = DiskCrawler.new(Mp3Processor.new(log))
      robot.scan(options[:dir])
      puts "_________DONE__________"
    else
      raise 'Error: No top directory specified!'
    end
  rescue Exception => ex
    puts ex
  end
end
