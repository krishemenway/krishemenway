#!/usr/bin/env ruby

task :refresh_steam_users => :environment do |t|
	steam_users = SteamUser.all
	steam_user_repository = SteamUserRepository.new

	steam_users.each do |user|
		steam_user_repository.load_games_for_user(user)
	end
end
