# encoding: utf-8

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.string :to_user_name , :comment => "用户微信openid"
    	t.string :from_user_name ,:comment => "开发者微信号"
    	t.datetime :create_time , :comment => "创建时间"
    	t.string :msg_type , 		:comment => "消息类型"
    	# t.text 	  :content , 			:comment => "文本内容"
    	t.integer :msg_id, 			:comment => "微信消息id"
    	t.belongs_to :relatable ,:polymorphic => true , :comment => "消息的多态类型"
    	# t.sting 	:pic_url , 	:comment => "图片链接"
    	# t.float   :location_x , :comment => "地理位置纬度"
    	# t.float   :location_y , :comment => "地理位置经度"
    	# t.sting   :scale , :comment => "地图缩放大小"
    	# t.sting   :label, :comment => "地理位置信息"
      t.timestamps
    end
  end
end
