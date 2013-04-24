# == Schema Information
#
# Table name: message_locations
#
#  id         :integer          not null, primary key
#  location_x :float
#  location_y :float
#  scale      :string(255)
#  label      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MessageLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
