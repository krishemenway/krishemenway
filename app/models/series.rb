class Series < ActiveRecord::Base
	attr_accessible :name, :rage_id

	has_many :episodes

	def as_json(options)
		{
			:name => self.name,
			:id => self.id
		}
	end
end
