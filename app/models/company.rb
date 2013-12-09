class Company < ActiveRecord::Base
	attr_accessible :name

	def as_json(options = {})
		{
			:name => self.name
		}
	end
end
