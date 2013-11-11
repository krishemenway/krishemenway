class CreateSteamGameTags < ActiveRecord::Migration
	def change
		create_table :steam_game_tags do |t|
			t.string :name

			t.timestamps
		end
	end
end
