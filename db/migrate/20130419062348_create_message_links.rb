class CreateMessageLinks < ActiveRecord::Migration
  def change
    create_table :message_links do |t|
    	t.string :title
    	t.string :description
    	t.string :url 
      t.timestamps
    end
  end
end
