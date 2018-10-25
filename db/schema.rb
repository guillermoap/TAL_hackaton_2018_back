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

ActiveRecord::Schema.define(version: 20181025140854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dealerships", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.jsonb "address_components", default: []
    t.string "formatted_address"
    t.string "formatted_phone_number"
    t.string "international_phone_number"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.jsonb "opening_hours", default: []
    t.string "google_place_id"
    t.text "tags", default: [], array: true
    t.string "country"
    t.string "city"
    t.decimal "rating", precision: 2, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_dealerships_on_city"
    t.index ["country"], name: "index_dealerships_on_country"
    t.index ["google_place_id"], name: "index_dealerships_on_google_place_id"
    t.index ["latitude"], name: "index_dealerships_on_latitude"
    t.index ["longitude"], name: "index_dealerships_on_longitude"
    t.index ["name"], name: "index_dealerships_on_name"
    t.index ["tags"], name: "index_dealerships_on_tags"
    t.index ["website"], name: "index_dealerships_on_website"
  end

end
