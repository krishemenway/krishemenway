class CreateMovies < ActiveRecord::Migration
	def change
		create_table :movies do |t|
			t.string :title
			t.date :released
			t.integer :length
			t.text :description
			t.integer :imdb_id

			t.timestamps
		end
	end
end
