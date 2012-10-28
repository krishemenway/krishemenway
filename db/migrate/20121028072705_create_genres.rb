class CreateGenres < ActiveRecord::Migration
	def change
		create_table :genres do |t|
			t.string :name

			t.timestamps
		end

		create_table :genres_movies, :id => false do |t|
			t.integer :genre_id
			t.integer :movie_id
		end
	end
end
