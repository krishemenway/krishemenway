#= require jquery
#= require jquery_ujs
#= require knockout

class BrowseMoviesViewModel
	constructor: (movies) ->
		self = this

		@movies = ko.observableArray(new MovieViewModel m for m in movies)
		@currentMovie = ko.observable()

		@shouldShowMovie = ko.observable(false)

		@gotoMovie = (movie) ->
			window.location.hash = movie.title
			self.shouldShowMovie(true)
			self.currentMovie(movie)

		@clearMovie = () ->
			self.shouldShowMovie(false)

class MovieViewModel
	constructor: (movie) ->
		@title = movie.title
		@poster_path = movie.poster_path
		@description = movie.description
		@id = movie.id
		@length = movie.length

window.BrowseMoviesViewModel = BrowseMoviesViewModel
window.MovieViewModel = MovieViewModel

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