#!/usr/bin/env ruby
require 'csv'

task :refresh_tvshows => :environment do |t|
	rageTVShowDataRetriever = RageTVShowDataRetriever.new
	rageTVShowDataRetriever.load_all_series_from_rage
end
