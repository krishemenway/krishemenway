Movies::Application.routes.draw do

	match "/calendar/events" => "calendar#events"
	match "/calendar" => "calendar#index"
	match "/movies" => "movies#browse"
	match "/tvshows" => "tvshows#browse"
	match "/projects" => "application#frontpage",  :as => "projects"
	root :to => "application#frontpage"
end
