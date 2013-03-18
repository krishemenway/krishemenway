require 'open-uri'
require 'csv'

class RageTVShowDataRetriever

	def retrieve_csv series
		series_data_result = open "http://epguides.com/common/exportToCSV.asp?rage=#{series.rage_id}" do |io| data = io.read end
		return /<pre>([^<]+)<\/pre>/.match(series_data_result)[1].strip
	end

	def load_all_series_from_rage options = {}
		Series.all.each do |series|
			load_series_from_rage series, options
		end
	end

	def load_series_from_rage series, options = {}
		options = {
			:initial_load => false
		}.merge(options)

		CSV.parse(retrieve_csv(series), :headers => :first_row) do |row|
			airdate = row[4].count("/") == 2 ? Date.parse(row[4].to_s) : nil rescue nil

			mappedEpisodeData = {
				:series_id => series.id,
				:episode_number => row[0].to_s.to_i,
				:season => row[1].to_s.to_i,
				:episode_in_season => row[2].to_s.to_i,
				:production_number => row[3].to_s,
				:airdate => airdate,
				:title => row[5].to_s.encode("utf-8", :invalid => :replace, :undef => :replace, :replace => ''),
				:is_special => row[6].to_s.to_bool,
				:rage_url => row[7].to_s
			}

			unless mappedEpisodeData.delete :is_special
				episode = Episode.where(:series_id => mappedEpisodeData[:series_id], :episode_number => mappedEpisodeData[:episode_number]).first

				if episode.present?
					episode.update_attributes mappedEpisodeData

					if episode.changed?
						episode.save
					end
				else
					episode = Episode.new! mappedEpisodeData

					if options[:initial_load]
						episode.last_updated = nil
						episode.created_at = nil
					end

					episode.save
				end
			end
		end
	end

end
