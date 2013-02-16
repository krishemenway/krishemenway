class CreateMovieCharacters < ActiveRecord::Migration
	def change
		create_table :movie_characters do |t|
			t.integer :movie_performance_id
			t.string :name

			t.timestamps
		end

		add_index :movie_characters, :movie_performance_id
		add_index :movie_characters, :name
	end
end
