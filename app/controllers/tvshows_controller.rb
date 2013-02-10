class TvshowsController < ApplicationController
	def browse
		@series = Series.all
	end
end
