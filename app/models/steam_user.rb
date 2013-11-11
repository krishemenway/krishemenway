class SteamUser < ActiveRecord::Base
	attr_accessible :steam_id, :steam_name, :user_id

	def self.find_by_user(user)
		self.find_by_user_id(user.id)
	end
end
