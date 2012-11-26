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

ActiveRecord::Schema.define(:version => 20121126220129) do

  create_table "items", :force => true do |t|
    t.string   "description"
    t.float    "price",           :default => 0.0
    t.integer  "purchases_count", :default => 0
    t.integer  "merchant_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "purchases_count", :default => 0
    t.integer  "items_count",     :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.integer  "purchases_count", :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "quantity",     :default => 0
    t.float    "total_price",  :default => 0.0
    t.integer  "purchaser_id"
    t.integer  "merchant_id"
    t.integer  "item_id"
    t.integer  "record_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "records", :force => true do |t|
    t.integer  "user_id"
    t.string   "status",                :default => "pending"
    t.string   "notes"
    t.integer  "purchases_count",       :default => 0
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "raw_data_file_name"
    t.string   "raw_data_content_type"
    t.integer  "raw_data_file_size"
    t.datetime "raw_data_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
