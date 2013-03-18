#!/usr/bin/env ruby
require 'csv'

task :'backfill-modify-dates' => :environment do |t|
	series_id = ENV["seriesid"]
	series = Series.find(series_id)
	DEFAULT_DATE = Date.new(1900)

	series.episodes.each do |episode|
		episode.created_at = episode.airdate || DEFAULT_DATE
		episode.updated_at = episode.airdate || DEFAULT_DATE
		episode.save!
	end
end