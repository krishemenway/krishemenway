
class FalloutViewModel
	constructor: () ->
		self = this
		wordLength = ko.observable(0)

		self.newWord = ko.observable()
		self.remainingWords = ko.observableArray()

		self.addWord = () ->
			if self.remainingWords().length == 0
				wordLength(self.newWord().length)

			if self.newWord().length == wordLength()
				self.remainingWords.push(self.newWord())
				self.newWord("")

		self.selectedWord = ko.observable()

		self.remainingWordLengths = ko.computed ->
			[0..wordLength()]

		self.numberOfLettersSelected = ko.observable()

		self.filterWordsOnNewInformation = () ->
			self.selectedWord()

			filteredWords = []

			for remainingWord in self.remainingWords()
				matches = 0
				for letter, i in remainingWord
					matches++ if letter == self.selectedWord()[i]
				if matches == self.numberOfLettersSelected()
					filteredWords.push(remainingWord)

			self.remainingWords(filteredWords)

window.FalloutViewModel = FalloutViewModel