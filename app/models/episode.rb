
class Episode < ActiveRecord::Base
	include Icalendar
	attr_accessible :airdate, :episode_in_season, :episode_number, :production_number, :season, :series_id, :title, :rage_url, :video_path

	validates :episode_number, :presence => true
	validates :season, :presence => true
	validates :episode_in_season, :presence => true

 	belongs_to :series

	def stream_path
		"#{ENV['EPISODE_STREAM_URL']}/#{self.series.name}/Season #{self.season}/#{self.filename}"
	end

	def filename
		"#{sprintf '%02d', self.season}x#{sprintf '%02d', self.episode_in_season} - #{self.title}.mp4"
	end

	def self.upcoming
		start_date = Date.today
		end_date = start_date + 40
		self.in_dates(start_date, end_date)
	end

	def self.on_date(date)
		self.in_dates(date.to_datetime.in_pacific.beginning_of_day, date.to_datetime.in_pacific.end_of_day)
	end

	def self.in_dates(start_date, end_date)
		where(:airdate => start_date..end_date).order(:airdate)
	end

	def as_ical
		event = Event.new

		event.start = self.airdate
		event.end = self.airdate
		event.summary = self.title
		event.description = self.title

		event
	end

	def to_xml(options = {}, &block)
		xml_properties = {
			:series_name => self.series.name,
			:series_id => self.series_id,
			:title => self.title,
			:airdate => self.airdate.to_s,
			:episode_in_season => self.episode_in_season,
			:episode_number => self.episode_number,
			:season => self.season,
			:video_path => self.video_path
		}

		xml_properties.to_xml options
	end

	def as_json(options = {})
		options = {
			:include_seasons => true,
			:include_series_name => false,
			:user_signed_in => false
		}.merge(options)

		{
			:series_name => options[:include_series_name] ? self.series.name : nil,
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
