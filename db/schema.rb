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

ActiveRecord::Schema.define(version: 20161107105743) do

  create_table "advertisers", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "telephone_no",           limit: 255
    t.string   "address",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
    t.string   "zip",                    limit: 255
    t.string   "username",               limit: 255
    t.string   "providerid",             limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "advertisers", ["email"], name: "index_advertisers_on_email", unique: true, using: :btree
  add_index "advertisers", ["reset_password_token"], name: "index_advertisers_on_reset_password_token", unique: true, using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.integer  "category_id",               limit: 4
    t.integer  "advertiser_id",             limit: 4
    t.text     "title",                     limit: 65535
    t.string   "message",                   limit: 255
    t.string   "description",               limit: 255
    t.text     "caption",                   limit: 65535
    t.string   "image",                     limit: 255
    t.string   "url",                       limit: 255
    t.string   "media_type",                limit: 255
    t.string   "platform_type",             limit: 255
    t.datetime "post_start_time"
    t.datetime "post_end_time"
    t.integer  "delay_time",                limit: 4
    t.boolean  "random_post_accounts",                    default: false
    t.boolean  "delete_after_finished",                   default: false
    t.boolean  "auto_pause_posts",                        default: false
    t.integer  "time_pause",                limit: 4
    t.integer  "after_complete_post_count", limit: 4
    t.boolean  "repeat_post",                             default: false
    t.string   "repeat_frequency",          limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "influencers", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.text     "name",                   limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "influencers", ["email"], name: "index_influencers_on_email", unique: true, using: :btree
  add_index "influencers", ["reset_password_token"], name: "index_influencers_on_reset_password_token", unique: true, using: :btree

  create_table "names", force: :cascade do |t|
    t.integer  "category_id",   limit: 4
    t.integer  "influencer_id", limit: 4
    t.integer  "advertiser_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "social_accounts", force: :cascade do |t|
    t.integer  "influencer_id",    limit: 4
    t.integer  "platform_type",    limit: 4
    t.text     "platform_type_id", limit: 65535
    t.text     "platform_link",    limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
