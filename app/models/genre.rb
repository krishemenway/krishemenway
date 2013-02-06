class Genre < ActiveRecord::Base
	attr_accessible :name

	def as_json(hii)
		{
			:id => self.id,
			:name => self.name
		}
	end
end
