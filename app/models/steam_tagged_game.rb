class SteamTaggedGame < ActiveRecord::Base
	attr_accessible :steam_app_id, :steam_game_tag_id

	belongs_to :steam_game_tag
	belongs_to :steam_game, :primary_key => 'app_id', :foreign_key => 'steam_app_id'
end
