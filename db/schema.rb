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

ActiveRecord::Schema.define(version: 20160104202233) do

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "skate_spot_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "street"
    t.integer  "street_num"
  end

  add_index "locations", ["skate_spot_id"], name: "index_locations_on_skate_spot_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "difficulty"
    t.integer  "police"
    t.integer  "pedestrian"
    t.string   "time"
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "skate_spot_id"
  end

  add_index "ratings", ["skate_spot_id"], name: "index_ratings_on_skate_spot_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "skate_spots", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.integer  "user_id"
    t.integer  "location_id"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "address"
    t.string   "street"
    t.string   "cross_street"
    t.integer  "street_num"
    t.integer  "rating_id"
  end

  add_index "skate_spots", ["location_id"], name: "index_skate_spots_on_location_id"
  add_index "skate_spots", ["rating_id"], name: "index_skate_spots_on_rating_id"
  add_index "skate_spots", ["user_id"], name: "index_skate_spots_on_user_id"

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
    t.integer  "rating_id"
    t.integer  "skate_spot_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["rating_id"], name: "index_users_on_rating_id"
  add_index "users", ["skate_spot_id"], name: "index_users_on_skate_spot_id"

end