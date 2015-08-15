class ChangeSteamGameFieldTypes < ActiveRecord::Migration
	def up
		change_column :steam_games, :about_the_game_description, :text
		change_column :steam_games, :detailed_description, :text
	end

	def down
		change_column :steam_games, :about_the_game_description, :string
		change_column :steam_games, :detailed_description, :string
	end
end
