
class FrontPageViewModel
	constructor: (events_by_date) ->
		self = this

		@days = ko.observableArray();

		@loadEventsForDay = (day, events) ->
			date = $.datepicker.parseDate('yy-mm-dd', day)
			@days.push new DayViewModel(date, events)

		self.loadEventsForDay date, events for date,events of events_by_date

window.FrontPageViewModel = FrontPageViewModel