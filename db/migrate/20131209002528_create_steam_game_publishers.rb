class CreateSteamGamePublishers < ActiveRecord::Migration
	def change
		create_table :steam_game_publishers do |t|
			t.integer :steam_app_id
			t.references :company

			t.timestamps
		end

		add_index :steam_game_publishers, :company_id
		add_index :steam_game_publishers, :steam_app_id
	end
end
