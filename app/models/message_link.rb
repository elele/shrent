# == Schema Information
#
# Table name: message_links
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MessageLink < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable
end
