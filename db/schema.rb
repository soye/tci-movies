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

ActiveRecord::Schema.define(version: 20170828132915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", primary_key: "tmdb_id", id: :integer, default: nil, force: :cascade do |t|
    t.string "name"
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.bigint "genre_id"
    t.bigint "movie_id"
    t.index ["genre_id"], name: "index_genres_movies_on_genre_id"
    t.index ["movie_id"], name: "index_genres_movies_on_movie_id"
  end

  create_table "movies", primary_key: "tmdb_id", id: :integer, default: nil, force: :cascade do |t|
    t.string "title", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "wilson_score", default: 1.0
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", default: 1
    t.text "comment", default: ""
    t.integer "movie_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id", "user_id"], name: "index_reviews_on_movie_id_and_user_id", unique: true
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
