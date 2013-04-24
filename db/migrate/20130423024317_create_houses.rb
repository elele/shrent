class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
    	t.string :title 
    	t.text :content
    	t.boolean :publish
    	t.string :avatar
      t.timestamps
    end
  end
end
