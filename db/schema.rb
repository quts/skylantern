<<<<<<< HEAD
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

ActiveRecord::Schema.define(:version => 20120530010821) do

  create_table "comments", :force => true do |t|
    t.string   "comment_id"
    t.string   "msg_id"
    t.string   "user_id"
    t.datetime "time"
    t.text     "content"
    t.text     "like"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "msgs", :force => true do |t|
    t.string   "msg_id"
    t.string   "title"
    t.text     "content"
    t.datetime "start_time"
    t.datetime "dead_time"
    t.text     "like"
    t.text     "lol"
    t.text     "vote_yes"
    t.text     "vote_no"
    t.text     "conclusion"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_id"
    t.string   "color"
    t.string   "user_name"
    t.string   "link"
  end

  create_table "users", :force => true do |t|
    t.string   "user_id"
    t.text     "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
=======
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

ActiveRecord::Schema.define(:version => 20120530204545) do

  create_table "comments", :force => true do |t|
    t.string   "comment_id"
    t.string   "msg_id"
    t.string   "user_id"
    t.datetime "time"
    t.text     "content"
    t.text     "like"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_name"
  end

  create_table "msgs", :force => true do |t|
    t.string   "msg_id"
    t.string   "title"
    t.text     "content"
    t.datetime "start_time"
    t.datetime "dead_time"
    t.text     "like"
    t.text     "lol"
    t.text     "vote_yes"
    t.text     "vote_no"
    t.text     "conclusion"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_id"
    t.string   "color"
    t.string   "user_name"
    t.text     "link"
  end

  create_table "users", :force => true do |t|
    t.string   "user_id"
    t.text     "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
>>>>>>> be36e74b3bef665d0c329161b7e82cde4d9f327b
