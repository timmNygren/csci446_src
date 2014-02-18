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

ActiveRecord::Schema.define(version: 20140218213045) do

  create_table "adopts", force: true do |t|
    t.integer  "pet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adopts", ["pet_id"], name: "index_adopts_on_pet_id"

  create_table "consider_adopts", force: true do |t|
    t.integer  "pet_id"
    t.integer  "consider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consider_adopts", ["consider_id"], name: "index_consider_adopts_on_consider_id"
  add_index "consider_adopts", ["pet_id"], name: "index_consider_adopts_on_pet_id"

  create_table "considers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foster_parents", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.integer  "pet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pets", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "breed"
    t.text     "coloring"
    t.text     "habits"
    t.string   "image_url"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "statuses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
