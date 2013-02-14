class Person < ActiveRecord::Base
	attr_accessible :dob, :first_name, :last_name, :worked_on_id, :worked_on_type

	has_many :movie_performances

	def as_json()
		{
			:person_id => self.id,
			:first_name => self.first_name,
		    :last_name => self.last_name
		}
	end
end
