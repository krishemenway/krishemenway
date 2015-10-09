class Series < ActiveRecord::Base
	attr_accessible :name, :rage_id, :set_slide_image_right, :set_slide_image_left

	has_attached_file :slide_image_left, :styles => {:full => "1024x150>", :half => "443x65>"}
	has_attached_file :slide_image_right, :styles => {:full => "1024x150>", :half => "443x65>"}

	validates_attachment_content_type :slide_image_left, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates_attachment_content_type :slide_image_right, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	validates :name, :uniqueness => true

	has_many :episodes

	has_many :user_series
	has_many :users, :through => :user_series

	def seasons
		self.episodes.group_by(&:season)
	end

	def set_slide_image_right= (image)
		image = get_slide_image(image)
		self.slide_image_left = image
	end

	def set_slide_image_left= (image)
		image = get_slide_image(image)
		self.slide_image_right = image
	end

	def remote_slide_image_location
		remote_slide_image_location = ENV['SERIES_SLIDE_IMAGE_LOCATION']
		raise 'Remote slide image location has not been defined in your environment' if remote_slide_image_location.nil?
		remote_slide_image_location
	end

	def get_slide_image(image)
		path = URI.escape(remote_slide_image_location + image)
		file = open(path)
		def file.original_filename; base_uri.path.split('/').last end
		file
	end

	def as_json(options = {})
		options = {
			:include_seasons => true
		}.merge(options)

		{
			:name => self.name,
			:id => self.id,
			:seasons => if options[:include_seasons] then self.seasons.as_json(options) else nil end,
			:slideImageLeft => self.slide_image_left.present? ? self.slide_image_left.url(:full) : nil,
			:slideImageRight => self.slide_image_right.present? ? self.slide_image_right.url(:full) : nil
		}
	end
end
