class TvshowsController < ApplicationController
	def index
		@series = Series.all

		respond_to do |format|
			format.html
			format.json { render :json => @series }
		end
	end

	def episode
		episode = params[:episode].to_s.to_i
		season = params[:season].to_s.to_i

		series = Series.find_by_name(params[:series_name])
		@episode = series.episodes.where(:episode_in_season => episode, :season => season).first

		respond_to do |format|
			format.xml { render :xml => @episode }
			format.json { render :json => @episode }
		end
	end
end
