
class GenreFilterViewModel
	constructor: (genre, genresFilterViewModel, filterViewModel) ->
		self = this

		self.id = genre.id
		self.name = genre.name

		self.filterViewModel = filterViewModel
		self.genresFilterViewModel = genresFilterViewModel

		self.isChecked = ko.observable(false)

		self.toggleCheck = ->
			isChecked = self.isChecked()
			self.genresFilterViewModel.clearAll()
			self.isChecked(!isChecked)
			self.filterViewModel.reloadMovies()

window.GenreFilterViewModel = GenreFilterViewModel