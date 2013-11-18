class SteamGameTag < ActiveRecord::Base
	attr_accessible :name, :example_one_app_id, :example_two_app_id

	has_many :steam_tagged_games
	has_many :steam_games, :through => :steam_tagged_games

	def example_one
		self.steam_games.first
	end

	def example_two
		self.steam_games.second
	end

	def as_json(options)
		{
			:name => self.name,
			:example_one => self.example_one.to_json(options),
			:example_two => self.example_two.to_json(options)
		}
	end
end
