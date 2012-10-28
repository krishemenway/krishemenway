class MoviesController < ApplicationController
	def index
		@movies = Movie.all.sort_by(&:title)
	end

	def index_by_alpha

	end

	def show
		@movie = Movie.find(params[:id])
	end
end
