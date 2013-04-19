# encoding: utf-8

class CreateMessageTexts < ActiveRecord::Migration
  def change
    create_table :message_texts do |t|
    	t.text 	  :content , 			:comment => "文本内容"
      t.timestamps
    end
  end
end
