#= require application

class BrowseMoviesViewModel
	constructor: (movies_by_genre, genres, decades) ->
		self = this

		@shouldShowFilters = ko.observable(true)
		@genreFilter = new GenreFiltersViewModel genres
		@decadeFilter = new DecadeFilterViewModel decades
		@letterFilter = new LetterFilterViewModel

		@movies_by_genre = ko.observable(new GenreViewModel genre for genre in movies_by_genre)
		@currentMovie = ko.observable()
		@secondMovie = ko.observable()

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
	constructor: () ->
		a = "a".charCodeAt(0)
		z = "z".charCodeAt(0)
		@letters = (new LetterViewModel String.fromCharCode(letter) for letter in [a..z])

class LetterViewModel
	constructor: (letter) ->
		self = this
		@letter = letter
		@isChecked = ko.observable(false)
		@toggleCheck = -> self.isChecked(!self.isChecked())

class DecadeFilterViewModel
	constructor: (decades) ->
		@decades = ko.observableArray(new DecadeViewModel d for d in decades)

class GenreFiltersViewModel
	constructor: (genres) ->
		@genres = ko.observableArray(new GenreFilterViewModel g for g in genres)

class GenreFilterViewModel
	constructor: (genre) ->
		self = this
		@name = genre.name
		@isChecked = ko.observable(false)
		@toggleCheck = -> self.isChecked(!self.isChecked())

class GenreViewModel
	constructor: (genre) ->
		@name = genre.name
		@id = genre.id
		@movies = ko.observableArray(new MovieViewModel m for m in genre.movies)

class DecadeViewModel
	constructor: (decade) ->
		self = this
		@year = decade
		@isChecked = ko.observable(false)
		@toggleCheck = -> self.isChecked(!self.isChecked())

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