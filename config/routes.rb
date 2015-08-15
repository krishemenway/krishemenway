Movies::Application.routes.draw do

	devise_for :users

	get '/reset' => 'application#reset'

	get '/projects' => 'projects#index'

	get '/movies' => 'movies#index'
	get '/movies/:movie_id/movie_performances' => 'movies#performances'

	get '/leaderboard' => 'leaderboard#index'
	get '/leaderboard/individuals' => 'leaderboard#individuals'
	get '/leaderboard/something' => 'leaderboard#something'

	get '/tvshows/series/:series_id' => 'tvshows#series'
	get '/tvshows/upcoming/in-2-days' => 'tvshows#in_2_days'
	get '/tvshows/upcoming/tomorrow' => 'tvshows#tomorrow'
	get '/tvshows/upcoming/today' => 'tvshows#upcoming'
	get '/tvshows/upcoming' => 'tvshows#upcoming'
	get '/tvshows/graph' => 'tvshows#graph'
	get '/tvshows/' => 'tvshows#index'

	get '/calendar/events' => 'calendar#events'
	get '/calendar' => 'calendar#index'

	get '/fallout' => 'application#fallout'

	post '/games/game/remove_tag' => 'games#remove_tag'
	post '/games/game/tag_game' => 'games#tag'
	post '/games/create_steam_user' => 'games#create_steam_user'

	get '/games/search/game' => 'games#search'
	get '/games/search/tag' => 'games#tags_like'
	get '/games/game/news' => 'games#news'
	get '/games/game/tags' => 'games#tags'

	post '/games/:steam_user_name' => 'games#create_steam_user'
	get '/games/:steam_user_name' => 'games#user_library'
	get '/games' => 'games#index'

	root :to => 'application#frontpage'
end
