class MoviesController < ApplicationController
	def browse
		@movies_by_genre = Genre.find([11,4,7]).map do |g| {:name => g.name, :id => g.id, :movies => g.movies} end
		@decades = Movie.all.group_by{|movie| movie.released.decade}.keys.sort
		@genres = Genre.all.sort_by(&:name)
	end
end
