# == Schema Information
#
# Table name: message_images
#
#  id         :integer          not null, primary key
#  pic_url    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageImage < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable
end
