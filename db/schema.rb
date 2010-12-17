# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101210083332) do

  create_table "opinions", :force => true do |t|
    t.integer  "session_user_id"
    t.integer  "topic_attribute_id"
    t.integer  "like_int"
    t.integer  "action_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opinions", ["action_type"], :name => "index_opinions_on_action_type"
  add_index "opinions", ["like_int"], :name => "index_opinions_on_like_int"
  add_index "opinions", ["session_user_id", "topic_attribute_id"], :name => "index_opinions_on_session_user_id_and_topic_attribute_id", :unique => true
  add_index "opinions", ["session_user_id"], :name => "index_opinions_on_session_user_id"
  add_index "opinions", ["topic_attribute_id"], :name => "index_opinions_on_topic_attribute_id"

  create_table "possible_names", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_user_messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_users", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.string   "given_username",                  :null => false
    t.float    "weight",         :default => 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "session_users", ["given_username"], :name => "index_session_users_on_given_username"
  add_index "session_users", ["topic_id"], :name => "index_session_users_on_topic_id"

  create_table "topic_attributes", :force => true do |t|
    t.string   "text"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_attributes", ["text"], :name => "index_topic_attributes_on_text"

  create_table "topics", :force => true do |t|
    t.string   "name",                   :null => false
    t.string   "description"
    t.string   "image_url",              :null => false
    t.string   "image_attribution_text"
    t.datetime "time_to_show",           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["name"], :name => "index_topics_on_name"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

end
