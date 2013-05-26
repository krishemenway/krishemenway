class LeaderboardController < ApplicationController
	def index
	end

	def individuals
		@individuals = []

		for i in 0..10000
			@individuals << {
				:name => "Test User #{i}",
				:score => Random.rand(100)
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
