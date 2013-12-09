class CreateSteamGameDevelopers < ActiveRecord::Migration
	def change
		create_table :steam_game_developers do |t|
			t.integer :steam_app_id
			t.references :company

			t.timestamps
		end

		add_index :steam_game_developers, :company_id
		add_index :steam_game_developers, :steam_app_id
	end
end
