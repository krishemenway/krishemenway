#!/usr/bin/env ruby

task :refresh_games => :environment do |t|
	steam_game_repository = SteamGameRepository.new
	steam_game_repository.refresh_all_games
end
