class SteamGame < ActiveRecord::Base
	attr_accessible :app_id, :name, :image_path, :metacritic_score, :metacritic_url, :app_type, :detailed_description,
	                :about_the_game_description, :supports_windows, :supports_osx, :supports_linux, :release_date,
	                :last_refresh_date

	has_many :steam_tagged_games, :primary_key => 'app_id', :foreign_key => 'steam_app_id'
	has_many :steam_game_tags, :through => :steam_tagged_games

	has_many :steam_game_publishers, :primary_key => 'app_id', :foreign_key => 'steam_app_id'
	has_many :publishers, :through => :steam_game_publishers, :source => 'company'

	has_many :steam_game_developers, :primary_key => 'app_id', :foreign_key => 'steam_app_id'
	has_many :developers, :through => :steam_game_developers, :source => 'company'

	def run_app_url
		"steam://run/#{self.app_id}"
	end

	def tag_game(tag)
		self.steam_game_tags << tag
		self.save
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

	def details_should_be_refreshed?
		self.last_refresh_date.present? and self.last_refresh_date <= DateTime::now.months_ago(1)
	end

	def as_json(options = {})
		{
			:app_id => self.app_id,
			:name => self.name,
			:run_url => self.run_app_url,
			:image_path => self.image_path,
			:release_date => self.release_date.present? ? self.release_date.strftime("%b %e, %Y") : '',
			:supports_windows => self.supports_windows?,
			:supports_osx => self.supports_osx?,
			:supports_linux => self.supports_linux?,
			:developers => self.developers.as_json(options),
			:publishers => self.publishers.as_json(options)
		}
	end
end
