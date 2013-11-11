class CreateSteamUserGames < ActiveRecord::Migration
	def change
		create_table :steam_user_games do |t|
			t.integer :steam_id, :limit => 8
			t.integer :steam_app_id

			t.timestamps
		end

		add_index :steam_user_games, [:steam_id, :steam_app_id], :unique => true
	end
end
