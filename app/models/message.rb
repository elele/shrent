# encoding: utf-8
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


class Message < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
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
			res_xml = message.relatable.render(xml)
		when "text"  #文本消息
			res_xml = text_rule(weixin_xml)
		when "location" # 地理消息
			message.relatable = MessageLocation.new
			message.relatable.location_x = weixin_xml["xml"]["Location_X"]
			message.relatable.location_y = weixin_xml["xml"]['Location_Y']
			message.relatable.scale = weixin_xml["xml"]["Scale"]
			message.relatable.label = weixin_xml["xml"]["Label"]
			message.save
			res_xml = Template.render_text(weixin_xml,"暂时还不支持地理位置查询.")
		when "image" #图片
			res_xml = House.add_image(weixin_xml)
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

	def self.text_rule(xml)
		# 文本规则处理
		content = xml['xml']["Content"]
		if content.include?("【出租】")
			return House.add_rent(xml)
		end
		if content.include?("【求租】")
			return House.add_rent(xml,House::HOUSE_TYPE_REQUEST)
		end
		if content == "help" or content == "h"
			return Template.render_text(xml,Template::HELP_MSG)
		end
		if content.include? "cz" #查看出租信息
			date = content.split(" ")[1]
			if date.blank?
				houses = House.today.publish.limit(5)
			else
				begin
					date = date.to_datetime if data.present?
				rescue ArgumentError => e 
					return Template.render_text(xml,"无效的日期!")
				end
				houses = House.date(date).publish.limit(5)
			end
			more_link = date.blank? ? "#{DOMIAN}/houses" : "#{DOMIAN}/houses?date=#{date.strftime('%Y-%m-%d')}"
			return Template.render_articles(xml,houses,more_link)
		end
	end

end
