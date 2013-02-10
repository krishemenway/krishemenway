class Episode < ActiveRecord::Base
	attr_accessible :airdate, :episode_in_season, :episode_number, :production_number, :season, :series_id, :title, :rage_url

 	belongs_to :series

	def as_json(options)
		{
			:title => self.title,
			:airdate => self.airdate.to_s,
			:episode_in_season => self.episode_in_season,
			:episode_number => self.episode_number,
			:season => self.season
		}
	end
end
