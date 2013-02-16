class MovieCharacter < ActiveRecord::Base
	attr_accessible :movie_performance_id, :name, :id

	belongs_to :movie_performance

	def as_json()
		{
			:name => self.name
		}
	end
end
