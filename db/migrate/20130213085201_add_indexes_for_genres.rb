class AddIndexesForGenres < ActiveRecord::Migration
	def change
		add_index :movie_genres, :genre_id
		add_index :movie_genres, :movie_id
	end
end
