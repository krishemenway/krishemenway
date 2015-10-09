require 'open-uri'
require 'csv'

class MazeTVShowDataRetriever

	def retrieve_csv(series)
		return open "http://epguides.com/common/exportToCSV.asp?rage=#{series.maze_id}" do |io| io.read end
	end

	def refresh_all(options = {})
		Series.all.each do |series|
			refresh_series(series, options)
		end
	end

	def refresh_series(series, options = {})
		options = {
			:initial_load => false
		}.merge(options)

		episodes = series.episodes

		CSV.parse(retrieve_csv(series), :headers => :first_row) do |row|
			airdate = row[3].count(" ") == 2 ? Date.parse(row[3].to_s) : nil rescue nil

			mappedEpisodeData = {
				:series_id => series.id,
				:is_special => row[0].to_s.to_i == 0,
				:episode_number => row[0].to_s.to_i,
				:season => row[1].to_s.to_i,
				:episode_in_season => row[2].to_s.to_i,
				:airdate => airdate,
				:title => row[4].to_s.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => ''),
				:rage_url => row[5].to_s
			}

			unless mappedEpisodeData.delete :is_special
				episode = episodes.where(:episode_number => mappedEpisodeData[:episode_number]).first

				if episode.present?
					episode.update_attributes mappedEpisodeData

					if episode.changed?
						episode.save
					end
				else
					episode = Episode.new mappedEpisodeData

					if options[:initial_load]
						episode.updated_at = episode.airdate
						episode.created_at = episode.airdate
					end

					episode.save!
				end
			end
		end
	end
end
