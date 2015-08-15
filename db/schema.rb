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

ActiveRecord::Schema.define(:version => 20131209002528) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.text     "video_path"
  end

  add_index "episodes", ["airdate"], :name => "index_episodes_on_airdate"
  add_index "episodes", ["episode_in_season"], :name => "index_episodes_on_episode_in_season"
  add_index "episodes", ["episode_number"], :name => "index_episodes_on_episode_number"
  add_index "episodes", ["season"], :name => "index_episodes_on_season"
  add_index "episodes", ["series_id"], :name => "index_episodes_on_series_id"

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

  create_table "movie_characters", :force => true do |t|
    t.integer  "movie_performance_id"
    t.string   "name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "movie_characters", ["movie_performance_id"], :name => "index_movie_characters_on_movie_performance_id"
  add_index "movie_characters", ["name"], :name => "index_movie_characters_on_name"

  create_table "movie_genres", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "movie_genres", ["genre_id"], :name => "index_movie_genres_on_genre_id"
  add_index "movie_genres", ["movie_id"], :name => "index_movie_genres_on_movie_id"

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
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.string   "title_first_letter",  :limit => 1
    t.text     "video_path"
  end

  add_index "movies", ["released"], :name => "index_movies_on_released"
  add_index "movies", ["title"], :name => "index_movies_on_title"

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
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "slide_image_left_file_name"
    t.string   "slide_image_left_content_type"
    t.integer  "slide_image_left_file_size"
    t.datetime "slide_image_left_updated_at"
    t.string   "slide_image_right_file_name"
    t.string   "slide_image_right_content_type"
    t.integer  "slide_image_right_file_size"
    t.datetime "slide_image_right_updated_at"
  end

  create_table "steam_game_developers", :force => true do |t|
    t.integer  "steam_app_id"
    t.integer  "company_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "steam_game_developers", ["company_id"], :name => "index_steam_game_developers_on_company_id"
  add_index "steam_game_developers", ["steam_app_id"], :name => "index_steam_game_developers_on_steam_app_id"

  create_table "steam_game_publishers", :force => true do |t|
    t.integer  "steam_app_id"
    t.integer  "company_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "steam_game_publishers", ["company_id"], :name => "index_steam_game_publishers_on_company_id"
  add_index "steam_game_publishers", ["steam_app_id"], :name => "index_steam_game_publishers_on_steam_app_id"

  create_table "steam_game_tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "example_one_app_id"
    t.integer  "example_two_app_id"
  end

  create_table "steam_games", :force => true do |t|
    t.string   "name"
    t.integer  "app_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "image_path"
    t.datetime "release_date"
    t.integer  "metacritic_score"
    t.string   "metacritic_url"
    t.string   "app_type"
    t.text     "detailed_description",       :limit => 255
    t.text     "about_the_game_description", :limit => 255
    t.boolean  "supports_windows"
    t.boolean  "supports_osx"
    t.boolean  "supports_linux"
    t.datetime "last_refresh_date"
  end

  add_index "steam_games", ["app_id"], :name => "index_steam_games_on_app_id", :unique => true

  create_table "steam_tagged_games", :force => true do |t|
    t.integer  "steam_game_tag_id"
    t.integer  "steam_app_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "steam_tagged_games", ["steam_app_id"], :name => "index_steam_tagged_games_on_steam_app_id"
  add_index "steam_tagged_games", ["steam_game_tag_id", "steam_app_id"], :name => "index_steam_tagged_games_on_steam_game_tag_id_and_steam_app_id", :unique => true
  add_index "steam_tagged_games", ["steam_game_tag_id"], :name => "index_steam_tagged_games_on_steam_game_tag_id"

  create_table "steam_user_games", :force => true do |t|
    t.integer  "steam_id",     :limit => 8
    t.integer  "steam_app_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "steam_user_games", ["steam_id", "steam_app_id"], :name => "index_steam_user_games_on_steam_id_and_steam_app_id", :unique => true

  create_table "steam_users", :force => true do |t|
    t.integer  "steam_id",   :limit => 8
    t.string   "steam_name"
    t.integer  "user_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "steam_users", ["steam_id"], :name => "index_steam_users_on_steam_id", :unique => true
  add_index "steam_users", ["user_id"], :name => "index_steam_users_on_user_id"

  create_table "user_series", :force => true do |t|
    t.integer  "user_id"
    t.integer  "series_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_series", ["series_id"], :name => "index_user_series_on_series_id"
  add_index "user_series", ["user_id"], :name => "index_user_series_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "can_edit"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "can_stream"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
