class SteamGameTag < ActiveRecord::Base
	attr_accessible :name
	has_many :steam_tagged_games
end
