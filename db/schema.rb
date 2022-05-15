# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_12_111845) do
  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "coutry_code"
    t.decimal "lat", precision: 20, scale: 8
    t.decimal "lon", precision: 20, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_location_settings", force: :cascade do |t|
    t.integer "cache_ttl"
    t.string "name"
    t.integer "user_id", null: false
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_user_location_settings_on_location_id"
    t.index ["user_id"], name: "index_user_location_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weather_logs", force: :cascade do |t|
    t.decimal "temp", precision: 6, scale: 2
    t.boolean "latest"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_weather_logs_on_location_id"
  end

  add_foreign_key "user_location_settings", "locations"
  add_foreign_key "user_location_settings", "users"
  add_foreign_key "weather_logs", "locations"
end
