#!/usr/bin/env ruby

namespace :steam_games do

	desc 'refresh a set of games'
	task :refresh_games, [:steam_app_ids] => [:environment] do |t,args|
		steam_game_repository = SteamGameRepository.new
		steam_app_ids = args[:steam_app_ids].split(' ').map do |app_id| app_id.to_i end

		steam_app_ids.each do |steam_app_id|
			game = SteamGame.find_by_app_id steam_app_id
			steam_game_repository.refresh_details_for_game game
		end
	end
end
