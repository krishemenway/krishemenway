
class LetterFilterViewModel
	constructor: (filterViewModel) ->
		self = this

		a = "a".charCodeAt(0)

		z = "z".charCodeAt(0)

		self.letters = (new LetterViewModel String.fromCharCode(letter), self, filterViewModel for letter in [a..z])

		self.getSelectedLetter = ->
			letters = self.letters.filter((letterViewModel) -> letterViewModel.isChecked())
			return if letters.length == 0 then "" else letters[0].letter

		self.clearAll = ->
			letter.isChecked(false) for letter in self.letters

window.LetterFilterViewModel = LetterFilterViewModel