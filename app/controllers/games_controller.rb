class GamesController < ApplicationController
	def index
		steam_game_retriever = SteamGameRetriever.new

		if params[:user].present?
			@steam_user = SteamUser.find_by_steam_name params[:user]

			if @steam_user.nil?
				@steam_user = SteamUser.new :steam_name => params[:user]
				@steam_user.steam_id = steam_game_retriever.get_steam_id @steam_user
				@steam_user.save!

				steam_game_retriever.load_games_for_user @steam_user
			end
		else
			if user_signed_in?
				@steam_user = SteamUser.find_by_user(current_user)

				if @steam_user.nil?
					redirect_to games_setup_url
					return
				end
			else
				redirect_to new_user_session_path
				return
			end
		end

		@recent_games = steam_game_retriever.get_recently_played_games(@steam_user).slice(0,5)
		@search_results = @steam_user.steam_games.slice(0,20)
		@tags = SteamGameTag.all

		respond_to do |format|
			format.html
		end
	end

	def tags_like
		@tags = SteamGameTag.where('name like ?', "%#{params[:query]}%").order(&:name)

		respond_to do |format|
			format.html { render :partial => 'games/game_list', :locals => { :tags => @tags } }
		end
	end

	def search
		query = params[:query].to_s

		@games = []

		if query.starts_with? 'tag:'
			@tag = SteamGameTag.where('name like ?', "%#{query.remove_leading_characters(4)}%")

			if @tag.nil?
				render :status => :ok
				return
			end

			@games = @tag.first.steam_games
		else
			@games = SteamGame.where('name like ?', "%#{query}%")
		end

		respond_to do |format|
			format.html { render :partial => 'games/game_list', :locals => { :games => @games } }
		end
	end

	def setup
	end

	def create_steam_user
		if user_signed_in?
			steam_game_retriever = SteamGameRetriever.new

			steam_user_params = {
				:user_id => current_user.id,
				:steam_name => params[:name],
				:steam_id => steam_game_retriever.get_steam_id_by_name(params[:name])
			}

			existing_user = SteamUser.find_by_steam_id(steam_user_params[:steam_id])
			steam_user = existing_user.present? ? existing_user : SteamUser.new(steam_user_params)
			steam_user.save!

			redirect_to games_path
		else
			redirect_to new_user_session_path
		end
	end
end