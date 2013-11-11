class AddImagePathToSteamGame < ActiveRecord::Migration
	def change
		add_column :steam_games, :image_path, :string
	end
end
