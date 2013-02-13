class MoviesController < ApplicationController
	def index
		@movies = Movie
			.includes(:movie_book_locations, :movie_genres, :genres)
			.that_starts_with(params[:letter])
			.that_has_genres(params[:genres])
			.limit(75)
			.order("title asc")

		@decades = Movie.all.group_by{|movie| movie.released.decade}.keys.sort
		@genres = Genre.all.sort_by(&:name)

		respond_to do |format|
			format.html
			format.json { render :json => @movies }
		end
	end
end
