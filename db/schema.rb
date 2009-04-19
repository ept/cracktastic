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

ActiveRecord::Schema.define(:version => 20090419233848) do

  create_table "companies", :force => true do |t|
    t.boolean  "is_self"
    t.string   "name"
    t.string   "contact_name"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "country_code"
    t.string   "tax_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jokes", :force => true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ledger_items", :force => true do |t|
    t.string   "type"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "issue_date"
    t.string   "currency",     :limit => 3,                                 :default => "GBP", :null => false
    t.decimal  "total_amount",               :precision => 20, :scale => 4
    t.decimal  "tax_amount",                 :precision => 20, :scale => 4
    t.string   "status",       :limit => 20
    t.string   "description"
    t.datetime "period_start"
    t.datetime "period_end"
    t.string   "uuid",         :limit => 40
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.string   "type"
    t.integer  "ledger_item_id"
    t.decimal  "net_amount",                   :precision => 20, :scale => 4
    t.decimal  "tax_amount",                   :precision => 20, :scale => 4
    t.string   "description"
    t.string   "uuid",           :limit => 40
    t.datetime "tax_point"
    t.decimal  "quantity",                     :precision => 20, :scale => 4
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "joke_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.integer  "company_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
