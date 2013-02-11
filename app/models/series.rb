class Series < ActiveRecord::Base
	attr_accessible :name, :rage_id

	validates :name, :uniqueness => true

	has_many :episodes

	def seasons
		self.episodes.group_by(&:season)
	end

	def as_json(options)
		{
			:name => self.name,
			:id => self.id,
			:seasons => self.seasons.as_json(options)
		}
	end
end
