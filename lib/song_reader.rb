#require "mp3info"
require 'taglib'
class SongReader
  def read_generic_file(file)
    TagLib::FileRef.open(file) do |fileref|
      tag = fileref.tag
    
      # Read basic attributes
      puts 'title: ' + tag.title.to_s   #=> "Wake Up"
      puts 'artist: ' + tag.artist.to_s  #=> "Arcade Fire"
      puts 'albulm: ' + tag.album.to_s   #=> "Funeral"
      puts 'year: ' + tag.year.to_s    #=> 2004
      puts 'track ' + tag.track.to_s   #=> 7
      puts 'genre ' + tag.genre.to_s   #=> "Indie Rock"
      puts 'comment ' +tag.comment.to_s #=> nil
    
      properties = fileref.audio_properties
      puts 'prop.length ' + properties.length.to_s  #=> 335 (song length in seconds)
    end
  end
  
  def read_mp3_file(file)
    tags = {}
    TagLib::MPEG::File.open(file) do |fh|
      tag = fh.id3v2_tag
      tags = {:title  => tag.title,
              :artist => tag.artist,
              :albulm => tag.album,
              :year   => tag.year,
              :track  => tag.track,
              :genre  => tag.genre,
              :comment=> tag.comment}
    
      # Attached picture frame
      cover = tag.frame_list('APIC').first
      if cover
        tags[:apic] = {:mime_type=>cover.mime_type, :pic=>cover.picture}
      end
    end
    return tags
  end
  
  def write_tags(file, tags)
    # tags v2 will be read and written according to the :encoding settings
    mp3 = Mp3Info.open(file, :encoding => 'utf-8')
    
    Mp3Info.open(file, :encoding => 'utf-8') do |mp3|
      # you can access four letter v2 tags like this
      puts mp3.tag2.TIT2
      mp3.tag2.TIT2 = "new TIT2"
      # or like that
      mp3.tag2["TIT2"]
      # at this time, only COMM tag is processed after reading and before writing
      # according to ID3v2#options hash
      mp3.tag2.options[:lang] = "FRE"
      mp3.tag2.COMM = "my comment in french, correctly handled when reading and writing"
    end
  end
end