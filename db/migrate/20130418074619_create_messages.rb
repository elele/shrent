# encoding: utf-8

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.string :to_user_name , :comment => "用户微信openid"
    	t.string :from_user_name ,:comment => "开发者微信号"
    	
      t.timestamps
    end
  end
end
