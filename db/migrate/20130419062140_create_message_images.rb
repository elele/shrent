# encoding: utf-8

class CreateMessageImages < ActiveRecord::Migration
  def change
    create_table :message_images do |t|
    	t.string 	:pic_url , 	:comment => "图片链接"
      t.timestamps
    end
  end
end
