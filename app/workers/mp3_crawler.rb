require 'logger'
require 'mp3_processor.rb'
require 'disk_crawler.rb'

class Mp3Crawler
  @queue = :mp3_scanner

  #This is how the worker should do, the entry point to a task to be done
  def self.perform(folder)
    log = Logger.new("#{Rails.root}/log/song_craw.log")
    robot = DiskCrawler.new(Mp3Processor.new(log))
    robot.scan(folder)
  end
end