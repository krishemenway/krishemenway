class LeaderboardController < ApplicationController
	def index
	end

	def something
		data = []

		for i in 0..10000
			data << {
				:rank => Random.rand(10000),
				:score => Random.rand(10000)
			}
		end

		respond_to do |format|
			format.json { render :json => data }
		end
	end

	def individuals
		@individuals = Rails.cache.fetch('leaderboard') do
			individuals = []
			teams = []

			teamCount = 20
			individualCount = 1000

			for i in 1..teamCount
				teams << {
					:external_id => Random.alphanumeric(5),
					:name => "Team #{Random.state_full}"
				}
			end

			for i in 1..individualCount
				individuals << {
					:name => "#{Random.first_name} #{Random.initial}",
					:score => Random.rand(100000),
					:team_external_id => teams[i % teamCount][:external_id],
					:days_entered => Random.rand(100),
					:average => Random.rand(10000)
				}
			end

			{
				:logged_in_user => individuals[0][:name],
				:individuals => individuals.sort_by { |individual| -individual[:score] },
				:teams => teams
			}
		end

		respond_to do |format|
			format.json { render :json => @individuals }
		end
	end

	def teams
		@teams = []

		for i in 0..10000
			@teams << {
				:name => "Test User #{i}",
				:score => Random.rand(100)
			}
		end
	end

	def my_team
		@individuals = []

		for i in 0..100
			@individuals << {
				:name => "Test User #{i}",
				:score => Random.rand(100)
			}
		end
	end
end
