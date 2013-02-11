class TvshowsController < ApplicationController
	def browse
		@series = Series.all

		respond_to do |format|
			format.html
			format.json { render :json => @series }
		end
	end
end
