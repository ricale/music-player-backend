require 'mp3info'

class Music < ApplicationRecord
  ALBUM_ARTIST = "TPE2"
  ALBUM_TITLE  = "TALB"
  ARTIST       = "TPE1"
  TITLE        = "TIT2"
  TRACK_NUMBER = "TRCK"
  DISC_NUMBER  = "TPOS"

  # 동일한 음악명에 대한 처리 필요:
  # - 메서드 시작 시 Music 일괄 삭제 후 일괄 생성
  # - music에 path 컬럼 추가
  # 이미지 관련 정보 저장 로직 필요
  def self.delete_and_recreate_all_musics
    file_names = Dir["#{Rails.root}/public/musics/**/*.mp3"]

    artist_hash = {}
    album_hash  = {}
    album_image_hash = {}

    image_errors = []

    Music.delete_all
    Album.delete_all
    Artist.delete_all

    get_artist = Proc.new {|record_hash, key, unique_attrs|
      if !key.blank? && record_hash[key].blank?
        record_hash[key] = Artist.where(unique_attrs).first_or_create!
      end
      record_hash[key]
    }

    file_names.each do |file_name|
      directory = "#{Rails.root}/public/images"

      Mp3Info.open("#{file_name}") do |mp3|
        # puts "#{mp3.tag.album} "\
        #   "#{mp3.tag.artist} "\
        #   "#{mp3.tag.tracknum} "\
        #   "#{mp3.tag.title} "\
        #   "#{mp3.tag2[ALBUM_ARTIST]} "\
        #   "#{mp3.tag2[DISC_NUMBER]}"

        title    = mp3.tag.title
        tracknum = mp3.tag.tracknum.to_i
        discnum  = mp3.tag2[DISC_NUMBER].to_i

        artist_name = mp3.tag.artist
        album_artist_name = mp3.tag2[ALBUM_ARTIST]
        album_title = mp3.tag.album

        artist = get_artist.call(
          artist_hash,
          artist_name,
          name: artist_name,
          artist_type_id: 1
        )

        album_artist = get_artist.call(
          artist_hash,
          album_artist_name,
          name: album_artist_name,
          artist_type_id: 2
        )

        if !album_title.blank? && album_hash[album_title].blank?
          album_hash[album_title] = Album.where(
            title:           album_title,
            artist_id:       artist.try(:id),
            album_artist_id: album_artist.try(:id)
          ).first_or_create!
        end
        album = album_hash[album_title]

        begin
          key = "#{album.try(:id)}_#{artist.try(:id)}_#{album_artist.try(:id)}"
          if album_image_hash[key].blank?
            album_image_hash[key] = MusicUtil.save_album_art_image_using_tag2_pictures(mp3, directory, key)
          end
          image_file_names = album_image_hash[key]

        rescue => e
          image_errors << mp3
        end

        Music.create!(
          title:           title,
          album_id:        album.try(:id),
          album_artist_id: album_artist.try(:id),
          artist_id:       artist.try(:id),
          tracknum:        tracknum,
          discnum:         discnum,
          path:            file_name,
          images:          image_file_names.to_s
        )
      end
    end

    image_errors
  end
end
