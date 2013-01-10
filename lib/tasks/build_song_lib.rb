require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'logger'
require 'optparse'
require 'disk_crawler.rb'
require 'mp3_processor.rb'

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
