class MoviesController < ApplicationController

	def default_movies
		Movie
			.includes(:movie_book_locations, :movie_genres, :genres)
			.order('title asc')
			.limit(50)
	end

	def filtered_movies(options)
		Movie
			.includes(:movie_book_locations, :movie_genres, :genres)
			.that_starts_with(options[:letter])
			.that_has_genres(options[:genres])
			.in_decade(options[:decades])
			.order('title asc')
	end

	def has_filters(options)
		[:letter, :genres, :decades].each do |filter|
			return true if options[filter].present?
		end
		false
	end

	def index
		respond_to do |format|
			format.html {
				@movies = default_movies
				@decades = Movie.all.group_by{|movie| movie.released.decade}.keys.sort.reverse
				@genres = Genre.all.sort_by(&:name)
				render
			}
			format.json {
				render :json => has_filters(params) ? filtered_movies(params) : default_movies, :include_path => true
			}
		end
	end

	def performances
		movie = Movie
			.includes(:movie_performances => [:person, :movie_characters])
			.find(params[:movie_id])

		@response = {
			:actors => movie.actors,
		    :directors => movie.directors,
		    :writers => movie.writers
		}

		respond_to do |format|
			format.json { render :json => @response }
		end
	end
end
