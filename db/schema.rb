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

ActiveRecord::Schema.define(:version => 20100707180314) do

  create_table "administrators", :force => true do |t|
    t.string   "name",               :limit => 25,                  :null => false
    t.string   "email",                             :default => "", :null => false
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.string   "password_salt",                     :default => "", :null => false
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                   :default => 0
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["email"], :name => "index_administrators_on_email", :unique => true
  add_index "administrators", ["name"], :name => "index_administrators_on_name", :unique => true

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
    t.string   "name",       :limit => 25, :null => false
    t.string   "pictureUri"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_tree", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "form_kind"
    t.string   "type"
    t.integer  "parent_id"
    t.integer  "lft",        :null => false
    t.integer  "rgt",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_values", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "config_tree_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "asset_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "validated",  :default => false, :null => false
  end

  add_index "deposits", ["user_id", "asset_id", "validated"], :name => "index_deposits_on_user_id_and_asset_id_and_validated", :unique => true

  create_table "guilds", :force => true do |t|
    t.string   "name"
    t.string   "pictureUri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.integer  "level",      :default => 0, :null => false
    t.string   "user",                      :null => false
    t.string   "action",                    :null => false
    t.string   "objectType",                :null => false
    t.integer  "objectId",                  :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id",                                    :null => false
    t.integer  "asset_id",                                    :null => false
    t.integer  "quantity",                                    :null => false
    t.decimal  "unitaryPrice", :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                     :null => false
    t.string   "state",      :limit => 30,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dispatched",               :default => false, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name",                 :limit => 25,                     :null => false
    t.integer  "pigMoneyBox",                         :default => 0,     :null => false
    t.integer  "guild_id"
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                :limit => 50,                     :null => false
    t.boolean  "gatherer",                            :default => false, :null => false
    t.string   "dofusNicknames"
    t.string   "confirmation_token"
    t.string   "reset_password_token"
    t.integer  "sign_in_count",                       :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0,     :null => false
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
