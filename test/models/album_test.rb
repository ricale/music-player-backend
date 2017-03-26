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

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
