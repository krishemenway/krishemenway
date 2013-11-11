class SteamTaggedGame < ActiveRecord::Base
	attr_accessible :steam_app_id, :steam_game_tag_id
	belongs_to :steam_game_tag
end
