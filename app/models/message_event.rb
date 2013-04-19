# encoding: utf-8

class MessageEvent < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :message ,:as => :relatable
  enum_attr :event , EVENT_TYPE

  WELCOME_MSG = %q|您好,感谢关注上海租房\n
  	功能正在紧张开发中,尽请期待.|

  def render
  	if self.event_subscribe? #关注返回
  		return TEXT_TPL % [self.message.to_user_name,self.message.from_user_name,
  								Time.now.to_i,WELCOME_MSG]
  	end			
  end	
end
