class SteamUserGame < ActiveRecord::Base
	attr_accessible :steam_app_id, :steam_id
end
