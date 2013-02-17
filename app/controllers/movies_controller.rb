class MoviesController < ApplicationController
	def index
		@movies = Movie
			.includes(:movie_book_locations, :movie_genres, :genres)
			.that_starts_with(params[:letter])
			.that_has_genres(params[:genres])
			.order("title asc")

		@decades = Movie.all.group_by{|movie| movie.released.decade}.keys.sort.reverse
		@genres = Genre.all.sort_by(&:name)

		respond_to do |format|
			format.html
			format.json { render :json => @movies }
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
