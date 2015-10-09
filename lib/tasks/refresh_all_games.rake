#!/usr/bin/env ruby

namespace :steam_games do
	desc 'Download all steam games\' metadata from steam'
	task :refresh_all_games => :environment do |t|
		steam_game_repository = SteamGameRepository.new
		steam_game_repository.refresh_all_games
	end
end

