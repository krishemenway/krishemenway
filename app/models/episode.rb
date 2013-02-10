
class Episode < ActiveRecord::Base
	include Icalendar
	attr_accessible :airdate, :episode_in_season, :episode_number, :production_number, :season, :series_id, :title, :rage_url

 	belongs_to :series

	def as_ical
		event = Event.new

		event.start = self.airdate
		event.end = self.airdate
		event.summary = self.title
		event.description = self.title

		event
	end

	def as_json(options)
		{
			:series_name => self.series.name,
			:series_id => self.series_id,
			:title => self.title,
			:airdate => self.airdate.to_s,
			:episode_in_season => self.episode_in_season,
			:episode_number => self.episode_number,
			:season => self.season
		}
	end
end
