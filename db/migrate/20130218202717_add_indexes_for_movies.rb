class AddIndexesForMovies < ActiveRecord::Migration
	def change
		add_column :movies, :title_first_letter, :string, :limit => 1

		Movie.all.each do |movie|
			movie.set_title_first_letter
			movie.save
		end

		add_index :movies, :released
		add_index :movies, :title
	end
end
