#!/usr/bin/env ruby

task :refresh_tvshows => :environment do |t|
	data_retriever = MazeTVShowDataRetriever.new
	data_retriever.refresh_all
end
