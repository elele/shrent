# == Schema Information
#
# Table name: houses
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  publish      :boolean
#  avatar       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  to_user_name :string(255)
#  house_type   :integer
#  price        :integer
#  address      :string(255)
#

require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
