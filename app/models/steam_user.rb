class SteamUser < ActiveRecord::Base
	attr_accessible :steam_id, :steam_name, :user_id

	has_many :steam_user_games, :foreign_key => 'steam_id', :primary_key => :steam_id
	has_many :steam_games, :through => :steam_user_games

	def self.find_by_user(user)
		self.find_by_user_id(user.id)
	end

	def as_json(options)
		{
			:steam_id => self.steam_id,
			:steam_name => self.steam_name
		}
	end
end
