Movies::Application.routes.draw do

	devise_for :users

	resources :movies, :only => [:index] do
		get 'movie_performances' => "movies#performances"
	end

	match "/tvshows/:series_name/season/:season/episode/:episode" => "tvshows#episode"
	match "/tvshows/" => "tvshows#index"
	match "/calendar/events" => "calendar#events"
	match "/calendar" => "calendar#index"
	match "/projects" => "application#frontpage",  :as => "projects"
	root :to => "application#frontpage"
end
