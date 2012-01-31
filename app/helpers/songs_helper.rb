module SongsHelper
  require "mp3info"

  def tags_on_file(song)
    Mp3Info.open(song.location, :encoding => 'utf-8') do |file|
      return file.tag
    end
  end
end
