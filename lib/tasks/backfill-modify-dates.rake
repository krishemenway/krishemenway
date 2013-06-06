#!/usr/bin/env ruby

task :'backfill-modify-dates' => :environment do |t|
	DEFAULT_DATE = Date.new(1900)

	Series.all.each do |series|
		series.episodes.each do |episode|
			episode.created_at = episode.airdate || DEFAULT_DATE
			episode.updated_at = episode.airdate || DEFAULT_DATE
			episode.save!
		end
	end
end