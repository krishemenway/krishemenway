class TvshowsController < ApplicationController
	def index
		@series = Series.all.sort_by(&:name)

		respond_to do |format|
			format.html
			format.json { render :json => @series, :user_can_stream => current_user_can_stream? }
		end
	end

	def series
		series_id = params[:series_id].to_s.to_i
		series = Series.find(series_id)

		respond_to do |format|
			format.json { render :json => series, :user_can_stream => current_user_can_stream? }
		end
	end

	def current_user_can_stream?
		user_signed_in? && current_user.can_stream
	end
end
