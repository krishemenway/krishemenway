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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130213080620) do

  create_table "episodes", :force => true do |t|
    t.string   "title"
    t.integer  "season"
    t.integer  "episode_number"
    t.integer  "episode_in_season"
    t.string   "production_number"
    t.date     "airdate"
    t.integer  "series_id"
    t.string   "rage_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "genres_movies", :id => false, :force => true do |t|
    t.integer "genre_id"
    t.integer "movie_id"
  end

  create_table "movie_book_locations", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "book_id"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movie_genres", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movie_performances", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "person_id"
    t.integer  "movie_role_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "movie_performances", ["movie_id"], :name => "index_movie_performances_on_movie_id"
  add_index "movie_performances", ["movie_role_id"], :name => "index_movie_performances_on_movie_role_id"
  add_index "movie_performances", ["person_id"], :name => "index_movie_performances_on_person_id"

  create_table "movie_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.date     "released"
    t.integer  "length"
    t.text     "description"
    t.integer  "imdb_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.integer  "rage_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
