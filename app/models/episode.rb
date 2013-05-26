
class Episode < ActiveRecord::Base
	include Icalendar
	attr_accessible :airdate, :episode_in_season, :episode_number, :production_number, :season, :series_id, :title, :rage_url, :video_path

	validates :episode_number, :presence => true
	validates :season, :presence => true
	validates :episode_in_season, :presence => true

 	belongs_to :series

	def stream_path
		"#{ENV['EPISODE_STREAM_URL']}/Season #{self.season}/#{self.filename}"
	end

	def filename
		"#{sprintf '%02d', self.season}x#{sprintf '%02d', self.episode_in_season} - #{self.title}.mp4"
	end

	def as_ical
		event = Event.new

		event.start = self.airdate
		event.end = self.airdate
		event.summary = self.title
		event.description = self.title

		event
	end

	def as_json(options = {})
		options = {
			:include_seasons => true,
			:user_signed_in => false
		}.merge(options)

		{
			:series_name => self.series.name,
			:series_id => self.series_id,
			:title => self.title,
			:airdate => self.airdate.to_s,
			:episode_in_season => self.episode_in_season,
			:episode_number => self.episode_number,
			:season => self.season,
			:video_path => self.video_path,
			:stream_path => options[:user_can_stream] ? self.stream_path : nil
		}
	end
end
