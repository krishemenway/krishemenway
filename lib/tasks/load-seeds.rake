#!/usr/bin/env ruby
require 'csv'

namespace :db do
	desc <<-EOS
		This task will load all seed data from csv
	EOS

	task :seed, :files, :ignore, :start do |t, args|
		Rails.logger.info "Started Loading Seeds"
		args.with_defaults(:files => 'movies genres movie_genres series people movie_roles movie_performances movie_characters', :ignore => '', :start => 0)

		ignore_field = args[:ignore]
		start_at = args[:start].to_s.to_i
		files = (args[:files] || '').split ','

		files.each do |file|
			csv_file  = File.join( File.dirname(__FILE__), '..', '..', 'db', 'fixtures', "#{file}.csv" )
			activerecord_model = file.singularize.titlecase.gsub(' ', '').constantize

			ActiveRecord::Base.transaction do

				CSV.foreach(csv_file, :headers => :first_row) do |row|
					next if ($INPUT_LINE_NUMBER < start_at)
					hashed_row = row.to_hash
					hashed_row.delete ignore_field

					if hashed_row.keys.include?('id')
						model_result = activerecord_model.find_by_id(hashed_row['id'])
					else
						key_0 = hashed_row.keys[0].to_sym
						key_1 = hashed_row.keys[1].to_sym

						model_result = activerecord_model.where(key_0 => hashed_row[hashed_row.keys[0]], key_1 => hashed_row[hashed_row.keys[1]]).first
					end

					if (model_result.is_a?(Array) and model_result.count == 0) or model_result.nil?
						created_obj = activerecord_model.new(hashed_row)
						created_obj.id = hashed_row['id']
						created_obj.save!

						puts "Created new #{activerecord_model.to_s} with id #{row['id']}"
					else
						if model_result.is_a?(Array)
							model_result = model_result.first
						end

						model_result.update_attributes!(hashed_row)
						puts "Updated #{activerecord_model.to_s} with id #{model_result.id}"
					end

				end

			end

		end

		Rails.logger.info "Finished Loading Seeds"
	end
end
