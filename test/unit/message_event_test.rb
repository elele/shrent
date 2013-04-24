# == Schema Information
#
# Table name: message_events
#
#  id         :integer          not null, primary key
#  event      :integer
#  event_key  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MessageEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
