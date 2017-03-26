# == Schema Information
#
# Table name: albums
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  artist_id       :integer
#  album_artist_id :integer
#  images          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Album < ApplicationRecord
  belongs_to :artist
  belongs_to :album_artist, foreign_key: :album_artist_id, class_name: 'Artist'

  has_many   :tracks, foreign_key: :album_id, class_name: 'Music'

  def self.update_images_by_musics
    images_hash =
      Music.select('DISTINCT(album_id), images').inject({}) do |hash, m|
        hash.merge({m.album_id => m.images})
      end

    Album.all.each do |album|
      album.update_attributes!(images: images_hash[album.id])
    end
  end

  def self.artist
    {
      name: 'test'
    }
  end
end
