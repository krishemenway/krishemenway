class ApplicationController < ActionController::Base
	protect_from_forgery

	def frontpage
		@episodes_by_date = Episode.upcoming.group_by(&:airdate)
		@latest_episodes_by_date = Episode.order("created_at desc").limit(5)

		respond_to do |format|
			format.html { render 'frontpage/index' }
		end
	end

	def fallout
		respond_to do |format|
			format.html { render 'fallout/hacker' }
		end
	end
end
