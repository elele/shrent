# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130424021856) do

  create_table "houses", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "publish"
    t.string   "avatar"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "to_user_name"
    t.integer  "house_type"
    t.integer  "price"
    t.string   "address"
  end

  add_index "houses", ["to_user_name"], :name => "index_houses_on_to_user_name"

  create_table "message_events", :force => true do |t|
    t.integer  "event"
    t.string   "event_key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_images", :force => true do |t|
    t.string   "pic_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_links", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "message_locations", :force => true do |t|
    t.float    "location_x"
    t.float    "location_y"
    t.string   "scale"
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_texts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.integer  "msg_id"
    t.integer  "relatable_id"
    t.string   "relatable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
