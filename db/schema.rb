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

ActiveRecord::Schema.define(version: 20150419140451) do

  create_table "conference_registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conference_id"
    t.integer  "receipt_id"
    t.string   "diet"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.string   "email"
    t.integer  "paper_id"
  end

  add_index "conference_registrations", ["conference_id"], name: "index_conference_registrations_on_conference_id"
  add_index "conference_registrations", ["paper_id"], name: "index_conference_registrations_on_paper_id"
  add_index "conference_registrations", ["receipt_id"], name: "index_conference_registrations_on_receipt_id"
  add_index "conference_registrations", ["user_id"], name: "index_conference_registrations_on_user_id"

  create_table "conferences", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "paper_fee"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.string   "month"
    t.integer  "year"
    t.integer  "cvv"
    t.string   "cc_type"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id"

  create_table "papers", force: :cascade do |t|
    t.string   "title"
    t.string   "authors"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "papers", ["user_id"], name: "index_papers_on_user_id"

  create_table "receipts", force: :cascade do |t|
    t.decimal  "total"
    t.integer  "credit_card_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "receipts", ["credit_card_id"], name: "index_receipts_on_credit_card_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

end
