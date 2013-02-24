class AddVideoPathToEpisodeAndMovie < ActiveRecord::Migration
	def change
		add_column :movies, :video_path, :text
		add_column :episodes, :video_path, :text
	end
end
