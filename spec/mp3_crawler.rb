require 'spec_helper'
require 'mp3_crawler.rb'

describe Mp3Crawler do
  let (:sample_folder) {"/Users/nhutthaile/sandbox/mp3"}
  let (:task){Task.create(:worker=>"Mp3Crawler", :target=>sample_folder, :status=>'PENDING')}

  it "imports all mp3 files" do
    Mp3Crawler.new.perform(sample_folder, task.id)
    Song.count().should == 2
  end

  it "mark task COMPLETED upon finished" do
    Mp3Crawler.new.perform(sample_folder, task.id)
    Task.find(task.id).status.should == 'COMPLETED'
  end
end