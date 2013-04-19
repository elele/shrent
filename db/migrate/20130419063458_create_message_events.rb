class CreateMessageEvents < ActiveRecord::Migration
  def change
    create_table :message_events do |t|
    	t.integer :event 
    	t.string :event_key
      t.timestamps
    end
  end
end
