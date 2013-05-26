Movies::Application.routes.draw do

	devise_for :users

	get '/projects' => 'projects#index'

	get '/movies' => 'movies#index'
	get '/movies/:movie_id/movie_performances' => 'movies#performances'

	get '/leaderboard' => 'leaderboard#index'
	get '/leaderboard/individuals' => 'leaderboard#individuals'

	get '/tvshows/series/:series_id' => 'tvshows#series'
	get '/tvshows/' => 'tvshows#index'

	get '/calendar/events' => 'calendar#events'
	get '/calendar' => 'calendar#index'

	get '/projects' => 'application#frontpage',  :as => 'projects'

	root :to => 'application#frontpage'
end
