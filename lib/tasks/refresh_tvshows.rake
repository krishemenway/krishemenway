#!/usr/bin/env ruby

task :refresh_tvshows => :environment do |t|
	Rails.logger.info "Started Refreshing TV Shows"
	RageTVShowDataRetriever.new.load_all_series_from_rage
	Rails.logger.info "Finished Refreshing TV Shows"
end
