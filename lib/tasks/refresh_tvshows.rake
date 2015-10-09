#!/usr/bin/env ruby

task :refresh_tvshows => :environment do |t|
	Rails.logger.info 'Started Refreshing TV Shows'
	MazeTVShowDataRetriever.new.refresh_all
	Rails.logger.info 'Finished Refreshing TV Shows'
end
