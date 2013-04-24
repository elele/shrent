# encoding: utf-8
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


class House < ActiveRecord::Base
  # attr_accessible :title, :body
  mount_uploader :avatar, AvatarUploader
  enum_attr :house_type ,HOUSE_TYPE
  validates :title ,:presence => {:message => "标题不能为空!"} 
  validates :address ,:presence => {:message => "地址不能为空!"} 
  validates :content ,:presence => {:message => "详情不能为空!"} 

  scope :today,where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day)
  scope :date ,lambda {|date| where(:created_at => date.beginning_of_day..date.end_of_day)}
  scope :publish, where(:publish => true)	

  def price
  	if self["price"] == 0 or self["price"].blank?
  		return "面议"
  	else
  		return self[:price]
  	end
  end

  #增加一条出租图片
  def self.add_image(xml)
  	h = House.where(:from_user_name => xml["xml"]['FromUserName']).today.first
  	if h && h.avatar.blank? #今天发布了一条消息,并且没有上传图片
  		file_name = "#{xml['xml']['ToUserName']}_#{Time.now.to_i}"
  		path = "#{Rails.root.join('public',file_name)}"
  		`wget -O #{path} #{xml["xml"]["PicUrl"]}`
  		h.avatar = File.open(path)
  		h.publish = true
  		h.save
  		File.delete(path)
  		if h.house_type_shrent?
  			text = "OK!,用户可以查询到你的出租信息了"
  		elsif h.house_type_request?
  			text = "OK!,用户可以查询到你的求租信息了"
  		end
  		return Template.render_text(xml,text)
  	else
  		if h.blank?
  			return Template.render_text(xml,"今天没有发布出租/求租消息\n请先发布出租/求租信息,在发送图片")
  		else
  			if h.avatar.present?
  				return Template.render_text(xml,"今天已发布过图片了!")
  			end
  		end
  	end
  end
  # 增加一条出租信息
  def self.add_rent(xml,type = 0)
  	h = House.where(:to_user_name => xml["xml"]['FromUserName'] ,:house_type => type).today.first
  	return Template.render_text(xml,"今天已发布过信息了,每个账号每天只能发布一条出租信息或求租信息.") if h.present?
  	info = xml["xml"]["Content"].split("/")
  	h = self.new
  	h.to_user_name = xml["xml"]['FromUserName']
  	h.title = info[0]
  	h.address = info[1]
  	h.content = info[2]
  	h.price = info[3] || 0  # 价格为0,面议
  	h.house_type = type
  	h.publish = false if type == 0
  	h.publish = true if type == 1
  	h.save
  	if h.errors.blank?
  		if h.house_type_shrent?
  			text = "发布成功,请发送一张出租房图片,才能正式通过."
  		elsif h.house_type_request?
  			text = "发布成功,求租消息,还可以上传一张照片,以增加求租成功率!"
  		end
  		Template.render_text(xml,text)
  	else
  		Template.render_text(xml,%Q|发布失败,请检查发布格式是否正确?
  	----- 错误信息 ----
  	#{h.errors.messages.map{|k,v| v} * "\n"}|)
  	end
  end
end
