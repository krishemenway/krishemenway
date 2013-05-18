class TvshowsController < ApplicationController
	def index
		@series = Series.includes(:episodes).sort_by(&:name)

		respond_to do |format|
			format.html
			format.json { render :json => @series }
		end
	end

	def series
		series_id = params[:series_id].to_s.to_i
		series = Series.find(series_id)

		respond_to do |format|
			format.json { render :json => series }
		end
	end
end
