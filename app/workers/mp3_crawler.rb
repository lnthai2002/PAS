require 'logger'
require 'mp3_processor.rb'
require 'disk_crawler.rb'

class Mp3Crawler
  include Sidekiq::Worker

  #This is how the worker should do, the entry point to a task to be done
  #Make sure that all lib used in this method are thread safe
  #Scan the given folder for mp3 and process them (record their tags in DB)
  def perform(folder)
    log = Logger.new("#{Rails.root}/log/song_craw.log")
    robot = DiskCrawler.new(Mp3Processor.new(log)) #dependency injection 
    robot.scan(folder)
  end
end