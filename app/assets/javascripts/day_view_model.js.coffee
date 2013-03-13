
class DayViewModel
	constructor: (date, events) ->
		self = this
		@date = date

		@events = events

		@getDate = (format) ->
			$.datepicker.formatDate(format, self.date)

window.DayViewModel = DayViewModel