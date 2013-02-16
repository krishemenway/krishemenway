class MoviePerformance < ActiveRecord::Base
	attr_accessible :movie_id, :movie_role_id, :person_id

	belongs_to :movie
	belongs_to :movie_role
	belongs_to :person

	has_many :movie_characters

	def as_json(options)
		{
			:person => self.person,
		    :characters => self.movie_characters
		}
	end
end
