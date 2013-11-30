#!/usr/bin/env ruby

task :refresh_steam_users => :environment do |t|
	steam_users = SteamUser.all
	steam_game_retriever = SteamGameRetriever.new

	steam_users.each do |user|
		steam_game_retriever.load_games_for_user(user)
	end
end
