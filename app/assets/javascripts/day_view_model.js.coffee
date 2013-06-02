
class DayViewModel
	constructor: (date, events) ->
		self = this

		self.date = date

		self.events = events

		self.getDate = (format) ->
			strftime(format, self.date)

window.DayViewModel = DayViewModel