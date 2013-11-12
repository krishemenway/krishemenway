class GamesController < ApplicationController
	def index
		steam_game_retriever = SteamGameRetriever.new

		if user_signed_in?
			@steam_user = SteamUser.find_by_user(current_user)

			if @steam_user.nil?
				respond_to do |format|
					format.html { render 'games/setup' }
				end
				return
			end

			@recent_games = steam_game_retriever.get_recently_played_games(@steam_user).slice(0,5)
			@search_results = SteamGame.all.slice(0,24)
			@top_tags = SteamGameTag.all

			respond_to do |format|
				format.html
			end
		else
			redirect_to new_user_session_path
		end
	end

	def setup
		if user_signed_in?
			steam_game_retriever = SteamGameRetriever.new

			steam_user_params = {
				:user_id => current_user.id,
				:steam_name => params[:name],
				:steam_id => steam_game_retriever.get_steam_id(params[:name])
			}

			SteamUser.create steam_user_params
			redirect_to games_path
		else
			redirect_to new_user_session_path
		end
	end
end