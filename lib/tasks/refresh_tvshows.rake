#!/usr/bin/env ruby

task :refresh_tvshows => :environment do |t|
	rage_data_retriever = RageTVShowDataRetriever.new
	rage_data_retriever.load_all_series_from_rage
end
