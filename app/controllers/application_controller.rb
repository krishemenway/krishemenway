class ApplicationController < ActionController::Base
	protect_from_forgery

	def frontpage
		start_date = Date.today
		end_date = start_date + 40
		@episodes_by_date = Episode.where(:airdate => start_date..end_date).order(&:airdate).group_by(&:airdate)
		@latest_episodes_by_date = Episode.order("updated_at desc").limit(10)

		respond_to do |format|
			format.html { render 'frontpage/index' }
		end
	end
end
