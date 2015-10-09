class AddMazeIdToSeries < ActiveRecord::Migration
	def change
		add_column :series, :maze_id, :integer
	end
end
