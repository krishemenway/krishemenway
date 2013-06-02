
class DayScoreViewModel
	constructor: (date, score) ->
		self = this

		self.date = date
		self.score = ko.observable(score)

		self.keyPress = (model, event) ->
			event.which >= '0'.charCodeAt(0) and event.which <= '9'.charCodeAt(0)

		self.getDate = (format) ->
			$.datepicker.formatDate(format, self.date)

window.DayScoreViewModel = DayScoreViewModel