class MovieBookLocation < ActiveRecord::Base
	attr_accessible :book_id, :movie_id, :page_id, :id

	belongs_to :movie

	def as_json(hii)
		{
			book_id: self.book_id,
			page_id: self.page_id
		}
	end
end
