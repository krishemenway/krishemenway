class GamesController < ApplicationController
	def index
		steam_game_retriever = SteamGameRetriever.new

		if user_signed_in?
			@steam_user = params[:user].present? ? SteamUser.find_by_steam_name(params[:user]) : SteamUser.find_by_user(current_user)

			if @steam_user.nil? and params[:user].nil?
				redirect_to games_setup_url
			end

			if @steam_user.nil?
				@steam_user = SteamUser.create :steam_name => params[:user]
				@steam_user.steam_id = steam_game_retriever.get_steam_id @steam_user
				@steam_user.save

				steam_game_retriever.load_games_for_user @steam_user
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

	def tags_like
		@tags = SteamGameTag.where('name like ?', "%#{params[:query]}%").order(&:name)

		respond_to do |format|
			format.json { render :json => @tags }
		end
	end

	def search
		query = params[:query].to_s

		@games = []

		if query.starts_with? 'tag:'
			@tag = SteamGameTag.find_by_name(query.slice(3)).first
			@games = @tag.steam_tagged_games.map do |steam_tagged_game|
				SteamGame.find_by_app_id steam_tagged_game.steam_app_id
			end
		else
			@games = SteamGame.where('name like ?', "%#{query}%")
		end

		respond_to do |format|
			format.json { render :json => @games }
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