class MovieRole < ActiveRecord::Base
	attr_accessible :name,:id

	has_many :movie_performances
end
