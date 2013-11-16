class SteamGame < ActiveRecord::Base
	attr_accessible :app_id, :name, :image_path

	has_many :steam_tagged_games, :primary_key => 'app_id', :foreign_key => 'steam_app_id'
	has_many :steam_game_tags, :through => :steam_tagged_games

	def run_app_url
		"steam://run/#{self.app_id}"
	end

	def self.from_xml(xml)
		game_hash = Hash.from_xml xml

		game_options = {
			:app_id => game_hash['game']['appID'],
			:name => game_hash['game']['name'],
			:image_path => game_hash['game']['logo']
		}

		SteamGame.new game_options
	end
end
