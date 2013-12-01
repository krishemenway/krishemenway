class GamesController < ApplicationController

	def recent_games(steam_user)
		SteamGameRetriever.new.get_recently_played_games(steam_user).slice(0,5)
	end

	def top_tags
		SteamGameTag.limit 10
	end

	def tags
		@game = SteamGame.find_by_app_id(params[:app_id])

		respond_to do |format|
			format.json { render :json => @game.steam_game_tags }
		end
	end

	def find_tag_by_name(name)
		tag = SteamGameTag.where 'lower(name) like ?', "%#{name.downcase}%"
		tag.present? ? tag.first : nil
	end

	def create_tag(name)
		SteamGameTag.create :name => name
	end

	def tag
		tag = find_tag_by_name(params[:tag_name])

		if tag.nil?
			tag = create_tag(params[:tag_name])
		end

		game = SteamGame.find_by_app_id(params[:app_id])
		game.tag_game(tag)

		respond_to do |format|
			format.json { render :json => tag }
		end
	end

	def news
		articles = SteamArticleRepository.new.find_articles_for_app_id params[:app_id]

		respond_to do |format|
			format.json { render :json => articles }
		end
	end

	def index
		if params[:user].present?
			@steam_user = SteamUser.find_by_steam_name params[:user]

			if @steam_user.nil?
				@steam_user = SteamUser.new :steam_name => params[:user]
				@steam_user.steam_id = SteamGameRetriever.new.get_steam_id @steam_user
				@steam_user.save!

				SteamGameRetriever.new.load_games_for_user @steam_user
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

		@is_viewing_own_profile = (user_signed_in? and current_user.id == @steam_user.user_id)

		@search_results = @steam_user.steam_games.slice(0,20)
		@recent_games = recent_games(@steam_user)
		@tags = top_tags

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

		games = []

		if query.present? and query.starts_with? 'tag:'
			if query.remove_leading_characters(4).blank?
				render :nothing => true
				return
			end

			tag = SteamGameTag.where('lower(name) like ?', "#{query.remove_leading_characters(4).downcase}")

			if tag.empty?
				render :nothing => true
				return
			end

			games = tag.first.steam_games
		elsif query.present?
			games = SteamGame.where('lower(name) like ?', "%#{query.downcase}%")
		end

		respond_to do |format|
			format.json { render :json => games }
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