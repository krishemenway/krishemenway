class AddIndexesForTvShows < ActiveRecord::Migration
	def change
		add_index :episodes, :season
		add_index :episodes, :episode_in_season
		add_index :episodes, :episode_number
		add_index :episodes, :airdate
		add_index :episodes, :series_id
	end
end
