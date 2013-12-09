require 'open-uri'

class SteamGameRepository

	def refresh_all_games(options = {})
		steam_games = SteamGame.all

		steam_games.each do |game|
			refresh_details_for_game(game, options)
		end
	end

	def load_details_for_game(steam_game)
		url = "http://store.steampowered.com/api/appdetails/?appids=#{steam_game.app_id}"
		puts url

		open(url) do |f|
			game_response = JSON.parse(f.read)[steam_game.app_id.to_s]

			if game_response['success']
				game_data = game_response['data']

				steam_game_attributes = {
					:app_type => game_data['type'],
					:detailed_description => game_data['detailed_description'],
					:about_the_game_description => game_data['about_the_game'],
					:supports_windows => game_data['platforms']['windows'],
					:supports_osx => game_data['platforms']['mac'],
					:supports_linux => game_data['platforms']['linux']
				}

				if game_data['metacritic'].present?
					steam_game_attributes[:metacritic_score] = game_data['metacritic']['score']
					steam_game_attributes[:metacritic_url] = game_data['metacritic']['url']
				end

				if game_data['developers'].present? and game_data['developers'].is_a?(Array)
					game_data['developers'].each do |dev|
						existing_company = Company.find_by_name dev

						if existing_company.nil?
							existing_company = Company.create :name => dev
						end

						steam_game.developers << existing_company
					end
				end

				if game_data['publishers'].present? and game_data['publishers'].is_a?(Array)
					game_data['publishers'].each do |dev|
						existing_company = Company.find_by_name dev

						if existing_company.nil?
							existing_company = Company.create :name => dev
						end

						steam_game.publishers << existing_company
					end
				end

				steam_game_attributes[:release_date] = Date.parse(game_data['release_date']['date']) if game_data['release_date']['date'].present?

				steam_game.update_attributes steam_game_attributes
			end
		end
	end

	def refresh_details_for_game(steam_game, options = {})
		options = {
			:force_refresh_all => false
		}.merge(options)

		if options[:force_refresh_all] or steam_game.details_should_be_refreshed?
			load_details_for_game(steam_game)
		end

		steam_game.last_refresh_date = DateTime::now
		steam_game.save
	end
end