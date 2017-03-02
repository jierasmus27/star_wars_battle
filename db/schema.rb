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

ActiveRecord::Schema.define(version: 20170302214120) do

  create_table "NewSeriesFilms_NewSeriesTeachers", id: false, force: :cascade do |t|
    t.integer "new_series_film_id",    null: false
    t.integer "new_series_teacher_id", null: false
  end

  create_table "new_series_films", force: :cascade do |t|
    t.integer  "episode_id"
    t.string   "opening_crawl"
    t.string   "director"
    t.string   "producer"
    t.datetime "release_date"
    t.integer  "new_series_person_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["new_series_person_id"], name: "index_new_series_films_on_new_series_person_id"
  end

  create_table "new_series_films_people", id: false, force: :cascade do |t|
    t.integer "new_series_film_id",   null: false
    t.integer "new_series_person_id", null: false
  end

  create_table "new_series_films_starships", id: false, force: :cascade do |t|
    t.integer "new_series_starship_id", null: false
    t.integer "new_series_film_id",     null: false
  end

  create_table "new_series_people", force: :cascade do |t|
    t.string   "name"
    t.integer  "height"
    t.integer  "mass"
    t.string   "hair_color"
    t.string   "skin_color"
    t.string   "eye_color"
    t.string   "birth_year"
    t.string   "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_series_people_starships", id: false, force: :cascade do |t|
    t.integer "new_series_starship_id", null: false
    t.integer "new_series_person_id",   null: false
  end

  create_table "new_series_starships", force: :cascade do |t|
    t.string   "name"
    t.string   "model"
    t.string   "manufacturer"
    t.integer  "cost_in_credits"
    t.integer  "length"
    t.string   "max_atmospheric_speec"
    t.integer  "crew"
    t.integer  "passengers"
    t.integer  "cargo_capacity"
    t.string   "consumables"
    t.string   "hyperdrive_rating"
    t.integer  "MGLT"
    t.string   "starship_class"
    t.integer  "new_series_people_id"
    t.integer  "new_series_films_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["new_series_films_id"], name: "index_new_series_starships_on_new_series_films_id"
    t.index ["new_series_people_id"], name: "index_new_series_starships_on_new_series_people_id"
  end

end