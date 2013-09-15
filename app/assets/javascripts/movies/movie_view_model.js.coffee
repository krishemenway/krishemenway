
class MovieViewModel
	constructor: (movie) ->
		self = this

		self.id = movie.id
		self.title = movie.title

		self.small_poster_path = movie.small_poster_path
		self.large_poster_path = movie.large_poster_path

		self.description = movie.description
		self.short_description = movie.short_description

		self.length = movie.length

		self.genres = ko.observableArray(JSON.parse(movie.genres))

		movieBookLocations = (new MovieBookLocationViewModel mbl for mbl in JSON.parse(movie.movie_book_locations))
		self.movie_book_locations = ko.observableArray(movieBookLocations)

		self.actors = ko.observableArray()
		self.directors = ko.observableArray()
		self.writers = ko.observableArray()

		self.load_performances = ->
			$.getJSON "/movies/#{self.id}/movie_performances", (data) ->
				self.actors(data.actors)
				self.writers(data.writers)
				self.directors(data.directors)

window.MovieViewModel = MovieViewModel