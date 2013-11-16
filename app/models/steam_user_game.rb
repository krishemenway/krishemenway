class SteamUserGame < ActiveRecord::Base
	attr_accessible :steam_app_id, :steam_id

	belongs_to :steam_user, :foreign_key => :steam_id, :primary_key => :steam_id
	belongs_to :steam_game, :foreign_key => :steam_app_id, :primary_key => :app_id
end
