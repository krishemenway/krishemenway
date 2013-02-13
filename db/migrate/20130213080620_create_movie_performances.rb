class CreateMoviePerformances < ActiveRecord::Migration
	def change
		create_table :movie_performances do |t|
			t.references :movie
			t.references :person
			t.references :movie_role

			t.timestamps
		end

		add_index :movie_performances, :movie_id
		add_index :movie_performances, :person_id
		add_index :movie_performances, :movie_role_id
	end
end
