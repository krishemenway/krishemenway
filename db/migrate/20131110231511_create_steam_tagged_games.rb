class CreateSteamTaggedGames < ActiveRecord::Migration
	def change
		create_table :steam_tagged_games do |t|
			t.references :steam_game_tag
			t.integer :steam_app_id

			t.timestamps
		end

		add_index :steam_tagged_games, :steam_game_tag_id
		add_index :steam_tagged_games, :steam_app_id

		add_index :steam_tagged_games, [:steam_game_tag_id, :steam_app_id], :unique => true
	end
end
