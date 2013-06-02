
class DayScoreViewModel
	constructor: (date, score) ->
		self = this

		self.maxScorePerDay = 50000

		self.date = date
		self.score = ko.observable(score)

		self.keyPress = (model, event) ->
			currentValue = event.currentTarget.value + String.fromCharCode(event.which)
			event.which >= '0'.charCodeAt(0) and event.which <= '9'.charCodeAt(0) and parseInt(currentValue || 0) <= self.maxScorePerDay

		self.getDate = (format) ->
			strftime(format, self.date)

window.DayScoreViewModel = DayScoreViewModel