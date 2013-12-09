class GamesController < ApplicationController
	def index
	end

	def user_library
		@steam_user = find_steam_user params[:steam_user_name]

		respond_to do |format|
			format.html {
				@search_results = @steam_user.steam_games.slice(0,20)
				@recent_games = recent_games(@steam_user)
				@tags = top_tags
			}
			format.json {
				render :json => @steam_user
			}
		end
	end

	def find_steam_user(name)
		user = SteamUser.includes(:steam_games).where('lower(steam_name) like ?', name)
		user.present? ? user.first : nil
	end

	def recent_games(steam_user)
		SteamUserRepository.new.get_recently_played_games(steam_user).slice(0,5)
	end

	def top_tags
		SteamGameTag.limit 5
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

	def tags_like
		existing_game_tags = SteamGame.find_by_app_id(params[:app_id]).steam_game_tags.map do |tag| tag.id end
		existing_game_tags.push(-1)

		tags = SteamGameTag.where('name like ? and id not in (?)', "%#{params[:query]}%", existing_game_tags).order(&:name)

		respond_to do |format|
			format.json { render :json => tags }
		end
	end

	def search
		query = params[:query].to_s
		steam_user = SteamUser.find_by_steam_id(params[:steam_id])

		search_results = { :games => [], :tags => [] }

		if query.present? and query.starts_with? 'tag:'
			tag_search_param = query.remove_leading_characters(4)

			if tag_search_param.present?
				single_tag = SteamGameTag.find_by_name(tag_search_param)

				if single_tag.present?
					search_results[:games] = single_tag.steam_games & steam_user.steam_games
				else
					tags = SteamGameTag.where('lower(name) like ?', "%#{tag_search_param.downcase}%")
					search_results[:tags] = tags
				end
			else
				search_results[:tags] = SteamGameTag.all.sort_by(&:name)
			end
		elsif query.present?
			steam_games = SteamGame.where('lower(name) like ?', "%#{query.downcase}%")
			search_results[:games] = steam_games & steam_user.steam_games
		end

		respond_to do |format|
			format.json { render :json => search_results }
		end
	end


	def create_steam_user
		steam_user_repository = SteamUserRepository.new
		steam_name = params[:steam_user_name]

		existing_user = find_steam_user(steam_name)

		if existing_user.nil?
			existing_user = SteamUser.new :steam_name => steam_name
			existing_user.steam_id = steam_user_repository.get_steam_id existing_user
			existing_user.save!
		end

		steam_user_repository.load_games_for_user existing_user

		respond_to do |format|
			format.html { render :json => existing_user }
			format.json { render :json => existing_user }
		end
	end
end