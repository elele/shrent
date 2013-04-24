# encoding: utf-8
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


class MessageEvent < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable
  enum_attr :event , EVENT_TYPE

  def render
  	if self.event_subscribe? #关注返回
  		return TEXT_TPL % [self.message.from_user_name,self.message.to_user_name,
  								Time.now.to_i,Template::HELP_MSG]
  	end			
  end	
end
