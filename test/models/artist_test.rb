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

require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
