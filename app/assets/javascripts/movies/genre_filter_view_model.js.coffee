
class GenreFilterViewModel
	constructor: (genre) ->
		self = this

		self.id = genre.id
		self.name = genre.name

		self.isChecked = ko.observable(false)

		self.toggleCheck = ->
			self.isChecked(!self.isChecked())

window.GenreFilterViewModel = GenreFilterViewModel