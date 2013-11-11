class CreateSteamGames < ActiveRecord::Migration
	def change
		create_table :steam_games do |t|
			t.string :name
			t.integer :app_id

			t.timestamps
		end

		add_index :steam_games, :app_id, :unique => true
	end
end
