
class DecadeViewModel
	constructor: (decade, decadesFilterViewModel, filterViewModel) ->
		self = this

		self.year = decade

		self.filterViewModel = filterViewModel

		self.decadesFilterViewModel = decadesFilterViewModel

		self.isChecked = ko.observable(false)

		self.toggleCheck = ->
			isChecked = self.isChecked()
			self.decadesFilterViewModel.clearAll()
			self.isChecked(!isChecked)
			self.filterViewModel.reloadMovies()

window.DecadeViewModel = DecadeViewModel