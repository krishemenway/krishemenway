class AddExampleColumnsToSteamGameTag < ActiveRecord::Migration
	def change
		add_column :steam_game_tags, :example_one_app_id, :integer
		add_column :steam_game_tags, :example_two_app_id, :integer
	end
end
