class Movie < ActiveRecord::Base
	attr_accessible :description, :imdb_id, :length, :released, :title, :id, :set_poster_by_filename
	has_attached_file :poster, :styles => {:medium => "300x450>", :thumb => "100x150>"}
	before_save :correct_movie_titles

	has_many :genres

	validates :poster, :attachment_size => {:in => 0..2.megabytes},
			  :attachment_content_type => {:content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/JPG']}

	def set_poster_by_filename=(filename)
		path = File.join(Rails.root, "app", "assets", "images", "posters", filename)
		self.poster = File.open(path)
	end

	def as_json(hii)
		{
			title: self.title,
			description: self.description,
			length: self.length,
			released: self.released,
			poster_path: self.poster.url(:thumb)
		}
	end

	def correct_movie_titles
		if self.title.downcase.starts_with? "the "
			self.title = "#{self.title.slice(4,self.title.length)}, The"
		end
	end
end
