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

ActiveRecord::Schema.define(:version => 20110508153634) do

  create_table "customer_titles", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.integer  "customer_title_id", :limit => 10
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "town"
    t.string   "county"
    t.string   "post_code"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile"
  end

  add_index "customers", ["first_name", "last_name", "company"], :name => "index_customers_on_first_name_and_last_name_and_company", :unique => true

  create_table "invoice_labours", :force => true do |t|
    t.integer  "invoice_id", :limit => 10
    t.text     "details",                                                :null => false
    t.decimal  "price",                    :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_parts", :force => true do |t|
    t.integer  "invoice_id", :limit => 10
    t.text     "details",                                                :null => false
    t.decimal  "price",                    :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "invoice_status_id", :limit => 10
    t.integer  "customer_id",       :limit => 10
    t.date     "date",                                                                             :null => false
    t.string   "make_model"
    t.string   "registration"
    t.integer  "mileage",           :limit => 10
    t.decimal  "mot",                             :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "environmental",                   :precision => 8, :scale => 2, :default => 6.0
    t.decimal  "vat_rate",                        :precision => 5, :scale => 2, :default => 20.0,  :null => false
    t.decimal  "vat",                             :precision => 8, :scale => 2,                    :null => false
    t.decimal  "subtotal",                        :precision => 8, :scale => 2,                    :null => false
    t.decimal  "total",                           :precision => 8, :scale => 2,                    :null => false
    t.boolean  "paid",                                                          :default => false
    t.date     "date_paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "customers", "customer_titles", :name => "customers_customer_title_id_fk"

  add_foreign_key "invoice_labours", "invoices", :name => "invoice_labours_invoice_id_fk"

  add_foreign_key "invoice_parts", "invoices", :name => "invoice_parts_invoice_id_fk"

  add_foreign_key "invoices", "customers", :name => "invoices_customer_id_fk"

end
