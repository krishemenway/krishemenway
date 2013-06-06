
class LetterViewModel
	constructor: (letter, lettersFilterViewModel, filterViewModel) ->
		self = this

		self.filterViewModel = filterViewModel

		self.lettersFilterViewModel = lettersFilterViewModel

		self.letter = letter

		self.isChecked = ko.observable(false)

		self.toggleCheck = ->
			isChecked = self.isChecked()
			self.lettersFilterViewModel.clearAll()
			self.isChecked(!isChecked)
			self.filterViewModel.reloadMovies()

window.LetterViewModel = LetterViewModel