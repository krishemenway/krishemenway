
class BrowseMoviesViewModel
	constructor: (movies, genres, decades) ->
		self = this

		@createMovies = (movies) ->
			return (new MovieViewModel movie for movie in movies)

		@shouldShowFilters = ko.observable(true)
		@genreFilter = new GenreFiltersViewModel genres, self
		@decadeFilter = new DecadeFilterViewModel decades, self
		@letterFilter = new LetterFilterViewModel self

		@movies = ko.observableArray(self.createMovies(movies))

		@currentMovie = ko.observable()
		@secondMovie = ko.observable()

		@reloadMovies = () ->
			movie_filters =
				letter: self.letterFilter.getSelectedLetter(),
				genres: self.genreFilter.getSelected()

			$.get "/movies.json", movie_filters, (movies) ->
				self.movies(self.createMovies(movies))

		@gotoMovie = (movie) ->
			window.location.hash = movie.title
			return if self.currentMovie() == movie or self.secondMovie() == movie

			if self.currentMovie()
				self.currentMovie(undefined)
				self.secondMovie(movie)
			else
				self.currentMovie(movie)
				self.secondMovie(undefined)

		@clearMovieOnEsc = (event) ->
			key = event.which if event.which else event.keyCode
			self.clearMovie if key == 13

		@clearMovie = () ->
			if self.currentMovie()
				self.currentMovie(undefined)
			else
				self.secondMovie(undefined)

class MovieViewModel
	constructor: (movie) ->
		@title = movie.title
		@small_poster_path = movie.small_poster_path
		@large_poster_path = movie.large_poster_path
		@description = movie.description
		@short_description = movie.short_description
		@id = movie.id
		@length = movie.length
		@movie_book_locations = ko.observableArray(new MovieBookLocationViewModel mbl for mbl in JSON.parse(movie.movie_book_locations))

class MovieBookLocationViewModel
	constructor: (movie_book_location) ->
		@book_id = movie_book_location.book_id
		@page_id = movie_book_location.page_id

class LetterFilterViewModel
	constructor: (filterViewModel) ->
		self = this
		a = "a".charCodeAt(0)
		z = "z".charCodeAt(0)
		@letters = (new LetterViewModel String.fromCharCode(letter), self, filterViewModel for letter in [a..z])

		@getSelectedLetter = ->
			letters = self.letters.filter((letterViewModel) -> letterViewModel.isChecked())
			return if letters.length == 0 then "" else letters[0].letter

		@clearAll = ->
			letter.isChecked(false) for letter in self.letters

class DecadeFilterViewModel
	constructor: (decades, filterViewModel) ->
		self = this
		@decades = ko.observableArray(new DecadeViewModel d, filterViewModel for d in decades)

class GenreFiltersViewModel
	constructor: (genres, filterViewModel) ->
		self = this
		@genres = ko.observableArray(new GenreFilterViewModel g, filterViewModel for g in genres)
		@getSelected = ->
			return (self.genres().filter((genreViewModel) -> genreViewModel.isChecked()) || []).map (genre) ->
				return genre.id

class LetterViewModel
	constructor: (letter, lettersFilterViewModel, filterViewModel) ->
		self = this
		@filterViewModel = filterViewModel
		@lettersFilterViewModel = lettersFilterViewModel
		@letter = letter
		@isChecked = ko.observable(false)
		@toggleCheck = ->
			isChecked = self.isChecked()
			self.lettersFilterViewModel.clearAll()
			self.isChecked(!isChecked)
			self.filterViewModel.reloadMovies()

class GenreFilterViewModel
	constructor: (genre, filterViewModel) ->
		self = this
		@filterViewModel = filterViewModel
		@name = genre.name
		@id = genre.id
		@isChecked = ko.observable(false)
		@toggleCheck = ->
			self.isChecked(!self.isChecked())
			self.filterViewModel.reloadMovies()

class DecadeViewModel
	constructor: (decade, filterViewModel) ->
		self = this
		@year = decade
		@filterViewModel = filterViewModel
		@isChecked = ko.observable(false)
		@toggleCheck = ->
			self.isChecked(!self.isChecked())
			self.filterViewModel.reloadMovies()

window.BrowseMoviesViewModel = BrowseMoviesViewModel

$ ->
	$(".back").on 'click', ->
		$overflowContainer = $(this).parent()
		$scrollableList = $(this).siblings("ul")
		width = parseInt($overflowContainer.innerWidth())
		currentLeft = parseInt($scrollableList.css("left")) || 0
		newLeft = if currentLeft - width >= 0 then currentLeft + width else 0
		$scrollableList.css("left", newLeft)

	$(".forward").on 'click', ->
		$overflowContainer = $(this).parent()
		$scrollableList = $(this).siblings("ul")
		width = parseInt($overflowContainer.innerWidth())
		currentLeft = parseInt($scrollableList.css("left")) || 0
		$scrollableList.css("left", currentLeft - width)