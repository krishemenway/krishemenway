
class GenreFiltersViewModel
	constructor: (genres) ->
		self = this

		self.selectedGenre = ko.observable(undefined)
		self.genreListVisible = ko.observable(false)

		self.toggleViewingGenres = () ->
			self.genreListVisible(!self.genreListVisible())

		self.genres = (new GenreViewModel g, self for g in genres)

		self.selectGenre = (targetGenre) ->
			newGenre = if self.selectedGenre() == targetGenre then undefined else targetGenre
			self.selectedGenre(newGenre)
			self.toggleViewingGenres()

		self.getSelectedGenre = () ->
			return if self.selectedGenre() != undefined then self.selectedGenre().id else ''

window.GenreFiltersViewModel = GenreFiltersViewModel