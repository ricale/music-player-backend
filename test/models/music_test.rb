# == Schema Information
#
# Table name: musics
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  artist_id       :integer
#  album_id        :integer
#  album_artist_id :integer
#  discnum         :integer
#  tracknum        :integer
#  path            :string(255)
#  images          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
