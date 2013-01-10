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