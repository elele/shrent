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
  # mount_uploader :avatar, AvatarUploader
  has_many :avatars
  has_one :avatar ,:order => "created_at desc"
  enum_attr :house_type ,HOUSE_TYPE
  validates :title ,:presence => {:message => "标题不能为空!"}
  # validates :address ,:presence => {:message => "地址不能为空!"}
  validates :content ,:presence => {:message => "详情不能为空!"}

  default_scope order("created_at desc")
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

  def add_image(xml)
    file_name = "#{xml['xml']['FromUserName']}_#{Time.now.to_i}"
    path = "#{Rails.root.join('public',file_name)}"
    `wget -O #{path} #{xml["xml"]["PicUrl"]}`
    avatar = self.avatars.build
    avatar.picture = File.open(path)
    self.publish = true
    self.save
    FileUtils.rm(path)
  end

  #增加一条出租图片
  def self.add_image(xml)
    h = House.where(:from_user_name => xml["xml"]['FromUserName']).today.first
    if h && h.avatars.blank? #今天发布了一条消息,并且没有上传图片
      h.add_image(xml)
      return Template.render_text(xml,"已成功上传图片")
    else
      if h.blank?
        return Template.render_text(xml,"今天没有发布出租/求租消息\n请先发布出租/求租信息,在发送图片")
      else
        if h.avatars.size >= 5
          return Template.render_text(xml,"不能超过5张照片!")
        else
          h.add_image(xml)
          return Template.render_text(xml,"已成功上传图片!")
        end
      end
    end
  end
  # 增加一条出租信息
  def self.add_rent(xml,type = 0)
    h = House.where(:from_user_name => xml["xml"]['FromUserName'] ,:house_type => type).today.first
    return Template.render_text(xml,"今天已发布过信息了,每个账号每天只能发布一条出租信息或求租信息.") if h.present?
    info = xml["xml"]["Content"]
    h = self.new
    h.from_user_name = xml["xml"]['FromUserName']
    h.title = info.slice(0,20)
    # h.address = info[1]
    h.content = info.slice(4,info.size)
    # h.price = info[3] || 0  # 价格为0,面议
    h.house_type = type
    h.publish = false if type == 0
    h.publish = true if type == 1
    h.save
    if h.errors.blank?
      if h.house_type_shrent?
        text = "发布成功,请发送止少一张出租房图片,才能正式通过."
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
