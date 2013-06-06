
class MovieBookLocationViewModel
	constructor: (movie_book_location) ->
		self.book_id = movie_book_location.book_id
		self.page_id = movie_book_location.page_id

window.MovieBookLocationViewModel = MovieBookLocationViewModel