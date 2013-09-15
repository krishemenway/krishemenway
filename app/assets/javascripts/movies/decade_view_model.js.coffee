
class DecadeViewModel
	constructor: (decade, decadesFilterViewModel) ->
		self = this

		self.year = decade

		self.decadesFilterViewModel = decadesFilterViewModel

		self.isChecked = ko.observable(false)

		self.toggleCheck = ->
			isChecked = self.isChecked()
			self.decadesFilterViewModel.clearAll()
			self.isChecked(!isChecked)

window.DecadeViewModel = DecadeViewModel