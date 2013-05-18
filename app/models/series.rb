class Series < ActiveRecord::Base
	attr_accessible :name, :rage_id

	has_attached_file :slide_image_left, :styles => {:full => "1024x150>", :half => "443x65>"}
	has_attached_file :slide_image_right, :styles => {:full => "1024x150>", :half => "443x65>"}

	validates :name, :uniqueness => true

	has_many :episodes

	def seasons
		self.episodes.group_by(&:season)
	end

	def as_json(options)
		{
			:name => self.name,
			:id => self.id,
			:seasons => self.seasons.as_json(options),
			:slideImageLeft => self.slide_image_left.url(:full),
			:slideImageRight => self.slide_image_right.url(:full)
		}
	end
end
