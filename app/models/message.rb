# encoding: utf-8

class Message < ActiveRecord::Base
	# attr_accessible :title, :body
	belongs_to :relatable ,:polymorphic => true

	def self.dispose(xml)
		weixin_xml = Hash.from_xml(xml)
		message = self.get_message(weixin_xml)
		type = weixin_xml["xml"]["MsgType"].downcase
		case type
		when "event" #消息事件
			message.relatable = MessageEvent.new
			message.relatable.event = EVENT_TYPE.find{|i| i[2] == weixin_xml["xml"]["Event"].downcase}[1]
			message.relatable.event_key = weixin_xml["xml"]["EventKey"]
			message.save
			res_xml = message.relatable.render
		when "text"  #文本消息
		when "location" # 地理消息
			message.relatable = MessageLocation.new
			message.relatable.location_x = weixin_xml["xml"]["Location_X"]
			message.relatable.location_y = weixin_xml["xml"]['Location_Y']
			message.relatable.scale = weixin_xml["xml"]["Scale"]
			message.relatable.label = weixin_xml["xml"]["Label"]
			message.save
			res_xml = message.relatable.render
		end
		res_xml || ""
	end

	def self.get_message(xml)
		message = Message.new
		message.to_user_name = xml["xml"]["ToUserName"]
		message.from_user_name = xml["xml"]["FromUserName"]
		message.create_time = Time.at(xml["xml"]["CreateTime"].to_i)
		message.msg_type = xml["xml"]["MsgType"].downcase
		message.msg_id = xml["xml"]["MsgId"].to_i if xml["xml"]["MsgId"].present?
		message
	end
end
