# encoding: utf-8

class CreateMessageLocations < ActiveRecord::Migration
  def change
    create_table :message_locations do |t|
    	t.float   :location_x , :comment => "地理位置纬度"
    	t.float   :location_y , :comment => "地理位置经度"
    	t.string   :scale , :comment => "地图缩放大小"
    	t.string   :label, :comment => "地理位置信息"
      t.timestamps
    end
  end
end
