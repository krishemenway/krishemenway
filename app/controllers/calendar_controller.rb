class CalendarController < ApplicationController
	def index
		@series = Series.all
		@events = get_events(DateTime::now.year, DateTime::now.month)

		respond_to do |format|
			format.html
			format.ics { render :text => make_ical(Episode.all) }
		end
	end

	def make_ical(episodes)
		@calendar = Icalendar::Calendar.new

		episodes.select do |ep|
			@calendar.add ep.as_ical
		end

		@calendar.publish
		@calendar.to_ical
	end

	def events
		respond_to do |format|
			format.json { render :json => get_events(params[:year], params[:month]) }
		end
	end

	private
	def get_events(year, month)
		start_date = Date.new(year.to_s.to_i, month.to_s.to_i, 1)
		end_date = Date.new(year.to_s.to_i, month.to_s.to_i, -1)

		episodes = Episode.where(:airdate => start_date..end_date)
		return episodes.group_by(&:airdate)
	end
end
