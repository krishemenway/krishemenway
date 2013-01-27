Movies::Application.routes.draw do

	resources :movies do
		collection do
			match 'browse'
		end
	end

	match "/tvshows" => "application#frontpage",  :as => "tvshows"
	match "/projects" => "application#frontpage",  :as => "projects"
	root :to => "application#frontpage"
end
