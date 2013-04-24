class AddColumnToUserNameForHouse < ActiveRecord::Migration
  def change
  	add_column :houses,:from_user_name,:string
  	add_index :houses,:from_user_name
  end
end
