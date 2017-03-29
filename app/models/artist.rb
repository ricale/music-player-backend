# == Schema Information
#
# Table name: artists
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  artist_type_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Artist < ApplicationRecord
  TYPE_ARTIST = 1
  TYPE_ALBUM_ARTIST = 2
end
