require "open-uri"

class Movie < ActiveRecord::Base
	attr_accessible :description, :imdb_id, :length, :released, :title, :id, :set_poster_by_filename, :released, :video_path
	has_attached_file :poster, :styles => {:medium => "300x450>", :thumb => "100x150>"}
	before_save :correct_movie_titles, :ensure_first_letter_is_set

	has_many :movie_genres
	has_many :genres, :through => :movie_genres

	has_many :movie_book_locations

	has_many :movie_performances

	validates :poster, :attachment_size => {:in => 0..2.megabytes},
			  :attachment_content_type => {:content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/JPG']}

	def self.that_starts_with(first_letter)
		if first_letter.present?
			where(:title_first_letter => first_letter)
		else
			where("1 = 1")
		end
	end

	def self.in_decade(decade)
		if decade.present?
			decade = decade.to_i
			start_date = Date.new(decade, 1, 1)
			end_date = Date.new(decade + 10, 1, 1)
			return where(:released => start_date..end_date)
		else
			return where("1 = 1")
		end
	end

	def self.that_has_genres(genres)
		out = includes(:movie_genres)
		out = out.where(:movie_genres => {:genre_id => genres} ) if genres.present?
		return out
	end

	def actors
		self.movie_performances.where :movie_role_id => 1
	end

	def directors
		self.movie_performances.where :movie_role_id => 2
	end

	def writers
		self.movie_performances.where :movie_role_id => 3
	end

	def set_poster_by_filename=(filename)
		poster_image_location = ENV['MOVIE_POSTER_IMAGE_LOCATION']
		file = open URI.escape("#{poster_image_location}/#{filename}")
		def file.original_filename; base_uri.path.split('/').last end
		self.poster = file
	end

	def short_description
		short_description_length = 20
		(self.description || '').split(/\s+/, short_description_length+1)[0...short_description_length].join(' ')
	end

	def as_json(options)
		options = {
			:include_path => false
		}.merge(options)

		{
			:id => self.id,
			:title => self.title,
			:description => self.description,
			:short_description => self.short_description,
			:length => self.length,
			:released => self.released,
			:small_poster_path => self.poster.url(:thumb),
			:large_poster_path => self.poster.url(:medium),
			:movie_book_locations => self.movie_book_locations.to_json,
			:genres => self.genres.to_json,
			:stream_path => options[:include_path] ? self.video_path : nil
		}
	end

	def correct_movie_titles
		if self.title.downcase.starts_with? "the "
			self.title = "#{self.title.slice(4,self.title.length)}, The"
		end
	end

	def ensure_first_letter_is_set
		if self.title_first_letter != self.title.downcase[0]
			set_title_first_letter
		end
	end

	def set_title_first_letter
		self.title_first_letter = self.title.downcase[0]
	end
end
