class Movie < ActiveRecord::Base
	attr_accessible :description, :imdb_id, :length, :released, :title, :id, :set_poster_by_filename
	has_attached_file :poster, :styles => {:medium => "300x450>", :thumb => "100x150>"}

	has_many :genres

	validates :poster, :attachment_presence => true,
			  :attachment_size => {:in => 0..2.megabytes},
			  :attachment_content_type => {:content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/JPG']}

	def set_poster_by_filename=(filename)
		path = File.join(Rails.root, "app", "assets", "images", "posters", filename)
		self.poster = File.open(path)
	end
end
