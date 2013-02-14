Movies::Application.routes.draw do

	resources :movies, :only => [:index] do
		get 'movie_performances' => "movies#performances"
	end

	match "/calendar/events" => "calendar#events"
	match "/calendar" => "calendar#index"
	match "/tvshows" => "tvshows#browse"
	match "/projects" => "application#frontpage",  :as => "projects"
	root :to => "application#frontpage"
end
