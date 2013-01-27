class MoviesController < ApplicationController
	def index
		@movies = Movie.all.sort_by(&:title)[0..20]
		@decades = @movies.group_by{|movie| movie.released.decade}.keys.sort
		@genres = Genre.all.sort_by(&:name)
	end

	def show
		@movie = Movie.find(params[:id])
	end
end
