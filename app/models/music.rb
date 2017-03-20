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
  def self.update_all_musics
    file_names = Dir["#{Rails.root}/public/musics/ost/*/*.mp3"]

    artist_hash = {}
    album_hash  = {}

    file_names.each do |file_name|
      Mp3Info.open("#{file_name}") do |mp3|
        puts "#{mp3.tag.album} "\
          "#{mp3.tag.artist} "\
          "#{mp3.tag.tracknum} "\
          "#{mp3.tag.title} "\
          "#{mp3.tag2[ALBUM_ARTIST]} "\
          "#{mp3.tag2[DISC_NUMBER]}"

        title = mp3.tag.title
        tracknum = mp3.tag.tracknum.to_i
        discnum  = mp3.tag2[DISC_NUMBER].to_i

        artist = mp3.tag.artist
        if !artist.blank? && artist_hash[artist].blank?
          artist_hash[artist] = Artist.where(name: artist).first_or_create!
        end
        artist = artist_hash[artist]

        album_artist = mp3.tag2[ALBUM_ARTIST]
        if !album_artist.blank? && artist_hash[album_artist].blank?
          artist_hash[album_artist] = Artist.where(name: album_artist).first_or_create!
        end
        album_artist = artist_hash[album_artist]

        album = mp3.tag.album
        if !album.blank? && album_hash[album].blank?
          album_hash[album] = Album.where(title: album).first_or_create!
        end
        album = album_hash[album]

        Music.where(
          album_id:        album.try(:id),
          album_artist_id: album_artist.try(:id),
          artist_id:       artist.try(:id),
          title:           title
        ).first_or_create!(
          tracknum: tracknum,
          discnum:  discnum
        )
      end
    end

    true
  end
end
