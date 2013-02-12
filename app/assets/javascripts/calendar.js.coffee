
class CalendarViewModel
	constructor: (initial_events) ->
		self = this
		@currentMonth = ko.observable(new Date)
		@events_by_date = ko.observable({})

		@header_date_format = 'MM yy'

		@loadEventsForDay = (day, events) ->
			self.events_by_date()[day] = events

		@loadEventsForDay date, events for date,events of initial_events

		@loadEventsForMonth = (date) ->
			$.get "/calendar/events.json", {year: date.getFullYear(), month: date.getMonth() + 1}, (events_by_date) ->
				self.loadEventsForDay date, events for date,events of events_by_date

		@lastMonth = ko.computed ->
			return new Date(self.currentMonth().getFullYear(), self.currentMonth().getMonth() - 1, 1)

		@nextMonth = ko.computed ->
			return new Date(self.currentMonth().getFullYear(), self.currentMonth().getMonth() + 1, 1)

		@currentMonthName = ko.computed ->
			return $.datepicker.formatDate(self.header_date_format, self.currentMonth())

		@lastMonthName = ko.computed ->
			return $.datepicker.formatDate(self.header_date_format, self.lastMonth())

		@nextMonthName = ko.computed ->
			return $.datepicker.formatDate(self.header_date_format, self.nextMonth())

		@events_for_day = (date) ->
			formatted_date = $.datepicker.formatDate("yy-mm-dd", date)
			return self.events_by_date()[formatted_date] || []

		@days = ko.computed ->
			month = self.currentMonth()
			days_in_month = new Date(month.getFullYear(), month.getMonth() + 1, 0).getDate()
			return (new DayViewModel(new Date(month.getFullYear(), month.getMonth(), day), self.events_for_day(new Date(month.getFullYear(), month.getMonth(), day))) for day in [1..days_in_month])

		@gotoNextMonth = ->
			self.currentMonth(self.nextMonth())
			self.loadEventsForMonth(self.nextMonth())

		@gotoLastMonth = ->
			self.currentMonth(self.lastMonth())
			self.loadEventsForMonth(self.lastMonth())

		@loadEventsForMonth(@lastMonth())
		@loadEventsForMonth(@nextMonth())


class DayViewModel
	constructor: (date, events) ->
		self = this
		@date = date

		@events = events

		@getDate = (format) ->
			$.datepicker.formatDate(format, self.date)

window.CalendarViewModel = CalendarViewModel