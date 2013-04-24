# == Schema Information
#
# Table name: message_texts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageText < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable
end
