# == Schema Information
#
# Table name: messages
#
#  id             :integer          not null, primary key
#  to_user_name   :string(255)
#  from_user_name :string(255)
#  create_time    :datetime
#  msg_type       :string(255)
#  msg_id         :integer
#  relatable_id   :integer
#  relatable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
