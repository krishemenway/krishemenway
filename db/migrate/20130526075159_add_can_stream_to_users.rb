class AddCanStreamToUsers < ActiveRecord::Migration
	def change
		add_column :users, :can_stream, :boolean
	end
end
