class CreateSteamUsers < ActiveRecord::Migration
	def change
		create_table :steam_users do |t|
			t.integer :steam_id, :limit => 8
			t.string :steam_name
			t.references :user

			t.timestamps
		end

		add_index :steam_users, :steam_id, :unique => true
		add_index :steam_users, :user_id
	end
end
