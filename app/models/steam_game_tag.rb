class SteamGameTag < ActiveRecord::Base
	attr_accessible :name

	has_many :steam_tagged_games
	has_many :steam_games, :through => :steam_tagged_games

	def example_one
		self.steam_games.first
	end

	def example_two
		self.steam_games.second
	end
end
