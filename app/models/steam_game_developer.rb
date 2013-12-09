class SteamGameDeveloper < ActiveRecord::Base
	attr_accessible :steam_app_id, :company_id

	belongs_to :company
end
