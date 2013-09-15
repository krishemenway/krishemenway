
class CalendarViewModel
	constructor: (initial_events) ->
		self = this

		monthNameFormat = '%B'
		yearNameFormat = '%Y'

		self.currentMonth = ko.observable(new Date)
		self.events_by_date = ko.observable({})

		self.loadEventsForDay = (day, events) ->
			self.events_by_date()[day] = events

		self.loadEventsForDay date, events for date,events of initial_events

		self.loadEventsForMonth = (date) ->
			$.getJSON "/calendar/events", {year: date.getFullYear(), month: date.getMonth() + 1}, (events_by_date) ->
				self.loadEventsForDay date, events for date,events of events_by_date

		self.lastMonth = ko.computed ->
			return new Date(self.currentMonth().getFullYear(), self.currentMonth().getMonth() - 1, 1)

		self.nextMonth = ko.computed ->
			return new Date(self.currentMonth().getFullYear(), self.currentMonth().getMonth() + 1, 1)

		self.currentMonthName = ko.computed ->
			return strftime(monthNameFormat, self.currentMonth())

		self.lastMonthName = ko.computed ->
			return strftime(monthNameFormat, self.lastMonth())

		self.nextMonthName = ko.computed ->
			return strftime(monthNameFormat, self.nextMonth())

		self.currentYearName = ko.computed ->
			return strftime(yearNameFormat, self.currentMonth())

		self.lastYearName = ko.computed ->
			return strftime(yearNameFormat, self.lastMonth())

		self.nextYearName = ko.computed ->
			return strftime(yearNameFormat, self.nextMonth())

		self.events_for_day = (date) ->
			formatted_date = strftime("%Y-%m-%d", date)
			return self.events_by_date()[formatted_date] || []

		self.days = ko.computed ->
			month = self.currentMonth()
			days_in_month = new Date(month.getFullYear(), month.getMonth() + 1, 0).getDate()
			return (new DayViewModel(new Date(month.getFullYear(), month.getMonth(), day), self.events_for_day(new Date(month.getFullYear(), month.getMonth(), day))) for day in [1..days_in_month])

		self.gotoNextMonth = ->
			self.currentMonth(self.nextMonth())
			self.loadEventsForMonth(self.nextMonth())

		self.gotoLastMonth = ->
			self.currentMonth(self.lastMonth())
			self.loadEventsForMonth(self.lastMonth())

		self.loadEventsForMonth(self.lastMonth())
		self.loadEventsForMonth(self.nextMonth())

window.CalendarViewModel = CalendarViewModel