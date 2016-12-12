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

ActiveRecord::Schema.define(version: 20161212093221) do

  create_table "admins", force: :cascade do |t|
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
    t.string   "contact_no",             limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id", limit: 4
    t.integer "role_id",  limit: 4
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "advertisements", force: :cascade do |t|
    t.string   "ad_type",            limit: 255
    t.text     "url",                limit: 65535
    t.text     "message",            limit: 65535
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.text     "caption",            limit: 65535
    t.integer  "time_post",          limit: 4
    t.integer  "delay",              limit: 4
    t.text     "advertisement_link", limit: 65535
    t.text     "after_complete",     limit: 65535
    t.boolean  "repeat"
    t.text     "end_date",           limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "advertiser_id",      limit: 4
    t.integer  "influencer_id",      limit: 4
    t.integer  "platform",           limit: 4
    t.integer  "status",             limit: 4
    t.integer  "category",           limit: 4
    t.text     "ad_image_url",       limit: 65535
    t.text     "reason_for_decline", limit: 65535
    t.text     "photo_click_link",   limit: 65535
  end

  create_table "advertisers", force: :cascade do |t|
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
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
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
    t.integer  "wallet_amount",          limit: 4
    t.string   "advertiser_type",        limit: 255
    t.text     "token",                  limit: 65535
    t.boolean  "is_verified"
  end

  add_index "advertisers", ["email"], name: "index_advertisers_on_email", unique: true, using: :btree
  add_index "advertisers", ["reset_password_token"], name: "index_advertisers_on_reset_password_token", unique: true, using: :btree

  create_table "app_configurations", force: :cascade do |t|
    t.string   "config_key",   limit: 255
    t.string   "config_value", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

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

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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
    t.integer  "facebook_page_count",    limit: 4
    t.integer  "instagram_page_count",   limit: 4
    t.integer  "wallet_amount",          limit: 4
    t.text     "category",               limit: 65535
    t.text     "publishing_price",       limit: 65535
    t.text     "token",                  limit: 65535
    t.boolean  "is_verified"
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

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "social_accounts", force: :cascade do |t|
    t.integer  "influencer_id",        limit: 4
    t.integer  "platform_type",        limit: 4
    t.text     "platform_type_id",     limit: 65535
    t.text     "platform_link",        limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "facebook_page_count",  limit: 4
    t.integer  "instagram_page_count", limit: 4
    t.text     "about",                limit: 65535
    t.text     "facebook_image_url",   limit: 65535
    t.text     "country",              limit: 65535
    t.text     "category",             limit: 65535
  end

end
