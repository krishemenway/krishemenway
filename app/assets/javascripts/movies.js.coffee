
#= require movies/movie_view_model
#= require movies/movie_book_location_view_model

#= require movies/decade_filter_view_model
#= require movies/decade_view_model

#= require movies/genre_filters_view_model
#= require movies/genre_filter_view_model

#= require movies/letter_filter_view_model
#= require movies/letter_view_model

class BrowseMoviesViewModel
	constructor: (movies, genres, decades) ->
		self = this

		self.createMovies = (movies) ->
			return (new MovieViewModel movie for movie in movies)

		self.shouldShowFilters = ko.observable(true)
		self.genreFilter = new GenreFiltersViewModel genres, self
		self.decadeFilter = new DecadeFilterViewModel decades, self
		self.letterFilter = new LetterFilterViewModel self

		self.movies = ko.observableArray(self.createMovies(movies))

		self.currentMovie = ko.observable()
		self.secondMovie = ko.observable()

		self.isDoubleWide = ko.observable(false)
		self.toggleDoubleWide = ->
			self.isDoubleWide(!self.isDoubleWide())

		self.reloadMovies = () ->
			movie_filters =
				letter: self.letterFilter.getSelectedLetter(),
				genres: self.genreFilter.getSelected(),
				decades: self.decadeFilter.getSelected()

			$.get "/movies.json", movie_filters, (movies) ->
				self.movies(self.createMovies(movies))

		self.gotoMovie = (movie) ->
			window.location.hash = movie.title
			movie.load_performances()
			self.isDoubleWide(false)
			if self.currentMovie() == movie or self.secondMovie() == movie
				self.currentMovie(undefined)
				self.secondMovie(undefined)
			else if self.currentMovie()
				self.currentMovie(undefined)
				self.secondMovie(movie)
			else
				self.currentMovie(movie)
				self.secondMovie(undefined)

		self.clearMovieOnEsc = (event) ->
			key = event.which if event.which else event.keyCode
			self.clearMovie if key == 13

		self.clearMovie = () ->
			if self.currentMovie()
				self.currentMovie(undefined)
			else
				self.secondMovie(undefined)

window.BrowseMoviesViewModel = BrowseMoviesViewModel

$ ->
	$('.movies .back').on 'click', ->
		$overflowContainer = $(this).parent()
		$scrollableList = $(this).siblings("ul")
		width = parseInt($overflowContainer.innerWidth())
		currentLeft = parseInt($scrollableList.css("left")) || 0
		newLeft = if currentLeft - width >= 0 then currentLeft + width else 0
		$scrollableList.css("left", newLeft)

	$('.movies .forward').on 'click', ->
		$overflowContainer = $(this).parent()
		$scrollableList = $(this).siblings("ul")
		width = parseInt($overflowContainer.innerWidth())
		currentLeft = parseInt($scrollableList.css("left")) || 0
		$scrollableList.css("left", currentLeft - width)