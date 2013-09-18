
class FalloutViewModel
	constructor: () ->
		self = this

		self.remainingWords = ko.observableArray()

		self.addNewWord = () ->
			self.remainingWords.push(new Word())
			self.remainingWords()[self.remainingWords().length - 1].hasFocus(true)

		self.selectedWord = ko.observable()

		currentWordLength = ->
			if self.remainingWords().length > 0 then self.remainingWords()[0].word().length else 0

		self.maxWordLength = ko.computed ->
			if self.remainingWords().length > 1 then self.remainingWords()[0].word().length else 99

		self.remainingWordLengths = ko.computed ->
			return [0..currentWordLength()]

		self.numberOfLettersSelected = ko.observable()

		self.filterWordsOnNewInformation = (model) ->
			filteredWords = []

			for remainingWord in self.remainingWords()
				matches = 0
				for letter, i in remainingWord.word()
					matches++ if letter.toLowerCase() == model.word()[i].toLowerCase()
				if matches == self.numberOfLettersSelected()
					filteredWords.push(remainingWord)

			self.remainingWords(filteredWords)

		self.addNewWord()

class Word
	constructor: () ->
		self = this
		self.word = ko.observable("")
		self.hasFocus = ko.observable(false)

window.FalloutViewModel = FalloutViewModel