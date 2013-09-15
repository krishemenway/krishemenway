
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

		self.genreFilter = new GenreFiltersViewModel genres
		self.decadeFilter = new DecadeFilterViewModel decades
		self.letterFilter = new LetterFilterViewModel self

		self.movies = ko.observableArray(self.createMovies(movies))

		self.currentMovie = ko.observable()
		self.secondMovie = ko.observable()

		self.isDoubleWide = ko.observable(false)
		self.toggleDoubleWide = ->
			self.isDoubleWide(!self.isDoubleWide())

		self.isReloading = ko.observable(false)
		self.shouldReloadAgain = false

		loadMovies = (movies) ->
			self.movies(self.createMovies(movies))
			self.isReloading(false)

			if(self.shouldReloadAgain)
				self.shouldReloadAgain = false
				self.reloadMovies()

		self.reloadMovies = () ->
			if(self.isReloading())
				self.shouldReloadAgain = true
			else
				movie_filters =
					letter: self.letterFilter.getSelectedLetter(),
					genres: self.genreFilter.getSelected() || [],
					decades: self.decadeFilter.getSelected()

				self.isReloading(true)
				$.getJSON "/movies", movie_filters, loadMovies


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

		(genreFilterViewModel.isChecked.subscribe(self.reloadMovies) for genreFilterViewModel in self.genreFilter.genres)
		(decadeViewModel.isChecked.subscribe(self.reloadMovies) for decadeViewModel in self.decadeFilter.decades)

window.BrowseMoviesViewModel = BrowseMoviesViewModel