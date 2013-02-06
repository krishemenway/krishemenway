#= require jquery
#= require jquery_ujs
#= require knockout

class BrowseMoviesViewModel
	constructor: (movies, genres, decades) ->
		self = this

		@genre_filter = new GenreFilterViewModel genres
		@decade_filter = new DecadeFilterViewModel decades

		@movies = ko.observableArray(new MovieViewModel m for m in movies)
		@currentMovie = ko.observable()

		@shouldShowMovie = ko.observable(false)

		@gotoMovie = (movie) ->
			window.location.hash = movie.title
			self.shouldShowMovie(true)
			self.currentMovie(movie) if self.currentMovie() != movie

		@clearMovie = () ->
			self.shouldShowMovie(false)

		@top_movies = ko.computed ->
			self.movies.slice(0,20)

class MovieViewModel
	constructor: (movie) ->
		@title = movie.title
		@poster_path = movie.poster_path
		@description = movie.description
		@short_description = movie.short_description
		@id = movie.id
		@length = movie.length
		@movie_book_locations = ko.observableArray(new MovieBookLocationViewModel mbl for mbl in JSON.parse(movie.movie_book_locations))

class MovieBookLocationViewModel
	constructor: (movie_book_location) ->
		@book_id = movie_book_location.book_id
		@page_id = movie_book_location.page_id

class DecadeFilterViewModel
	constructor: (decades) ->
		@decades = ko.observableArray(new DecadeViewModel d for d in decades)

class GenreFilterViewModel
	constructor: (genres) ->
		@genres = ko.observableArray(new GenreViewModel g for g in genres)

class GenreViewModel
	constructor: (genre) ->
		self = this
		@name = genre.name
		@isChecked = ko.observable(false)
		@toggleCheck = -> self.isChecked(!self.isChecked())

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