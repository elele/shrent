class AddColumnForHouses < ActiveRecord::Migration
  def change
  	add_column :houses,:house_type ,:integer
  	add_column :houses,:price,:integer
  	add_column :houses,:address,:string
  end
end
