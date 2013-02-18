class MoviesController < ApplicationController
	def index
		respond_to do |format|
			format.html {
				@movies = Movie
					.includes(:movie_book_locations, :movie_genres, :genres)
					.order("title asc")
					.limit(50)

				@decades = Movie.all.group_by{|movie| movie.released.decade}.keys.sort.reverse
				@genres = Genre.all.sort_by(&:name)
				render
			}
			format.json {
				@movies = Movie
					.includes(:movie_book_locations, :movie_genres, :genres)
					.that_starts_with(params[:letter])
					.that_has_genres(params[:genres])
					.in_decade(params[:decades])
					.order("title asc")

				render :json => @movies
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
