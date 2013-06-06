class CreateUserSeries < ActiveRecord::Migration
	def change
		create_table :user_series do |t|
			t.references :user
			t.references :series

			t.timestamps
		end

		add_index :user_series, :user_id
		add_index :user_series, :series_id
	end
end
