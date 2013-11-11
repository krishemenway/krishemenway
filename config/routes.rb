Movies::Application.routes.draw do

	devise_for :users

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

	get '/games' => 'games#index'
	post '/games/setup' => 'games#setup'

	root :to => 'application#frontpage'
end
