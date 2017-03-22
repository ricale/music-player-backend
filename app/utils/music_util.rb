require 'mp3info'

module MusicUtil
  PNG_REGEXP = Regexp.new([0x89].pack('c*') + "PNG")
  JPG_REGEXP = Regexp.new([0xFF,0xD8].pack('c*'))

  def self.save_album_art_image_using_tag2_pictures(mp3, directory, file_name = nil)
    image_file_names = []
    mp3.tag2.pictures.each_with_index do |(description, data), index|
      extension = 
        if data =~ PNG_REGEXP
          '.png'
        elsif data =~ JPG_REGEXP
          '.jpg'
        else
          nil
        end

      image_file_name = "#{file_name}_#{index}#{extension}"
      image_file_path = "#{directory}/#{image_file_name}"

      # if !File.exist?(image_file_path)
        File.open(image_file_path, 'wb') do |f|
          f.write(data)
        end
      # end

      image_file_names << image_file_name
    end

    image_file_names
  end

  def self.save_album_art_image_using_tag2(mp3, directory)
    description = 'apic'
    data = mp3.tag2["APIC"]
    
    extension = 
      if data =~ PNG_REGEXP
        '.png'
      elsif data =~ JPG_REGEXP
        '.jpg'
      else
        nil
      end

    image_file_name = "#{description}#{extension}"
    image_file_path = "#{directory}/#{image_file_name}"

    if !File.exist?(image_file_path)
      File.open(image_file_path, 'wb') do |f|
        f.write(data)
      end
    end

    [image_file_name]
  end
end
