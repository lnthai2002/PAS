module TagInfo
  require "mp3info"
  USEFULL_TAGS = ['title', 'artist', 'album', 'tracknum', 'genre', 'comments']
  def tag_of(file)
    Mp3Info.open(file, :encoding => 'utf-8') do |mp3info|
      return mp3info.tag
    end
  end
end