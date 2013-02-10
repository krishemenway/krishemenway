class CalendarController < ApplicationController
	def index
		@series = Series.all
	end
end
