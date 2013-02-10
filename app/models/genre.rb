class Genre < ActiveRecord::Base
	attr_accessible :name

	has_many :movie_genres
	has_many :movies, :through => :movie_genres

	def as_json(options)
		{
			:id => self.id,
			:name => self.name
		}
	end
end
