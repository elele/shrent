class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
    	t.belongs_to :house
    	t.string :picture
      t.timestamps
    end
  end
end
