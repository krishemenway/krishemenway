#!/usr/bin/env ruby
require 'csv'

namespace :db do
	desc <<-EOS
		This task will load all seed data from csv
	EOS

	task :seed => :environment do |t|
		files = (ENV["t"] || "").split "," || ['genres']

		files.each do |file|
			csv_file  = File.join( File.dirname(__FILE__), '..', '..', 'db', 'fixtures', "#{file}.csv" )
			activerecord_model = file.singularize.titlecase.gsub(" ","").constantize

			CSV.foreach(csv_file, :headers => :first_row) do |row|
				hashed_row = row.to_hash

				if hashed_row.keys.include?("id")
					model_result = activerecord_model.find_all_by_id(hashed_row["id"])
				else
					key_0 = hashed_row.keys[0].to_sym
					key_1 = hashed_row.keys[1].to_sym

					model_result = activerecord_model.where(key_0 => hashed_row[hashed_row.keys[0]], key_1 => hashed_row[hashed_row.keys[1]]).first
				end

				if (model_result.is_a?(Array) and model_result.count == 0) or model_result.nil?
					created_obj = activerecord_model.new(hashed_row)
					created_obj.id = hashed_row["id"]
					created_obj.save!

					puts "Created new #{activerecord_model.to_s} with id #{row["id"]}"
				else
					if model_result.is_a?(Array)
						model_result = model_result.first
					end

					model_result.update_attributes(hashed_row)
					model_result.save!

					puts "Updated #{activerecord_model.to_s} with id #{model_result.id}"
				end

			end

		end

	end
end
