class ApplicationController < ActionController::Base
	protect_from_forgery

	def frontpage
		start_date = Date.today
		end_date = start_date + 40
		@episodes_by_date = Episode.where(:airdate => start_date..end_date).group_by(&:airdate)

		respond_to do |format|
			format.html { render "frontpage/default" }
		end
	end
end
