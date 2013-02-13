require "open-uri"

class Movie < ActiveRecord::Base
	attr_accessible :description, :imdb_id, :length, :released, :title, :id, :set_poster_by_filename
	has_attached_file :poster, :styles => {:medium => "300x450>", :thumb => "100x150>"}
	before_save :correct_movie_titles

	has_many :movie_genres
	has_many :genres, :through => :movie_genres

	has_many :movie_book_locations

	has_many :movie_performances
	has_many :movies, :through => :movie_performances

	validates :poster, :attachment_size => {:in => 0..2.megabytes},
			  :attachment_content_type => {:content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/JPG']}

	def self.that_starts_with(start_with_string)
		where("lower(title) like lower(?)", (start_with_string || "") + "%")
	end

	def self.that_has_genres(genres)
		out = joins(:movie_genres)
		out = out.where(:movie_genres => {:genre_id => genres} ) unless genres.nil?
		return out
	end

	def set_poster_by_filename=(filename)
		path = URI.escape("http://coyotesrestaurant.com/krishemenway/movies/images/movies/#{filename}")
		file = open(path)
		def file.original_filename; base_uri.path.split('/').last end
		self.poster = file
	end

	def short_description
		short_description_length = 20
		(self.description || "").split(/\s+/, short_description_length+1)[0...short_description_length].join(' ')
	end

	def as_json(options)
		{
			:title => self.title,
			:description => self.description,
			:short_description => self.short_description,
			:length => self.length,
			:released => self.released,
			:small_poster_path => self.poster.url(:thumb),
			:large_poster_path => self.poster.url(:medium),
			:movie_book_locations => self.movie_book_locations.to_json,
		    :genres => self.genres.to_json
		}
	end

	def correct_movie_titles
		if self.title.downcase.starts_with? "the "
			self.title = "#{self.title.slice(4,self.title.length)}, The"
		end
	end
end
