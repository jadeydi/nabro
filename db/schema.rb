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

ActiveRecord::Schema.define(version: 20150823060231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "moods", force: :cascade do |t|
    t.datetime "ended_at"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "moods", ["user_id"], name: "index_moods_on_user_id", using: :btree

  create_table "user_auths", force: :cascade do |t|
    t.string   "provider"
    t.string   "open_id"
    t.text     "original"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_auths", ["provider", "open_id"], name: "index_user_auths_on_provider_and_open_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.string   "refresh_token"
    t.string   "avatar_url"
    t.string   "profile_url"
    t.string   "location"
    t.string   "languages"
    t.string   "nickname"
    t.integer  "gender"
    t.string   "provider"
    t.string   "uid"
    t.text     "bio"
    t.datetime "last_clicked_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

end
