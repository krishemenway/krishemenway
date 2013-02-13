class MoviePerformance < ActiveRecord::Base
	attr_accessible :movie_id, :movie_role_id, :person_id

	belongs_to :movie
	belongs_to :movie_role
	belongs_to :person
end
