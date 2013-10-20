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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131019202250) do

  create_table "expense_categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.decimal  "max_limit",   default: 0.0
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expense_categories", ["slug"], name: "index_expense_categories_on_slug", unique: true

  create_table "expenses", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.decimal  "amount"
    t.boolean  "status",      default: false
    t.boolean  "rejected",    default: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", force: true do |t|
    t.string   "name"
    t.date     "_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_applications", force: true do |t|
    t.text     "reason"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "num_of_days"
    t.integer  "user_id"
    t.integer  "category_id"
    t.boolean  "status",      default: false
    t.boolean  "rejected",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "used_leaves"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "content"
    t.string   "subject"
    t.boolean  "is_conversation"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
