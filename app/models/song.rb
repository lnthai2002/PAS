class Song < ActiveRecord::Base
  def update_tags_on_file(dataset)
    Mp3Info.open(location, :encoding => 'utf-8') do |song|
      dataset.each do |tag, value|
        song.tag.send(tag, value)
      end
=begin
      song.tag2.options[:lang] = "FRE"
      song.tag2.COMM = "my comment in french, correctly handled when reading and writing"
=end
    end
  end
end
