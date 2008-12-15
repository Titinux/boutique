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

ActiveRecord::Schema.define(:version => 20081215002523) do

  create_table "assets", :force => true do |t|
    t.string   "name",         :limit => 25,                                                 :null => false
    t.integer  "category_id",                                                                :null => false
    t.string   "pictureUri"
    t.decimal  "unitaryPrice",               :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.boolean  "floatPrice",                                                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "asset_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guilds", :force => true do |t|
    t.string   "name"
    t.string   "pictureUri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id",   :null => false
    t.integer  "asset_id",   :null => false
    t.integer  "quantity",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "state",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "guild_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
