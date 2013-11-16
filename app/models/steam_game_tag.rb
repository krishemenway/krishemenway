class SteamGameTag < ActiveRecord::Base
	attr_accessible :name, :example_one_app_id, :example_two_app_id

	has_many :steam_tagged_games
	has_many :steam_games, :through => :steam_tagged_games

	def example_one
		self.steam_games.where('app_id = ?', example_one_app_id).first
	end

	def example_two
		self.steam_games.where('app_id = ?', example_two_app_id).first
	end
end
