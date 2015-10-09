#!/usr/bin/env ruby

task :'backfill-modify-dates' => :environment do |t|
	DEFAULT_DATE = Date.new(1900)

	Series.all.each do |series|
		series.episodes.each do |episode|
			new_record_date = episode.airdate || DEFAULT_DATE
			new_record_date = if new_record_date <= DateTime.now then new_record_date else DateTime.now end

			episode.created_at = new_record_date
			episode.updated_at = new_record_date
			episode.save!
		end
	end
end