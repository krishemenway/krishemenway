#= require application
#= require jquery-ui

class CalendarViewModel
	constructor: () ->
		self = this
		@currentMonth = ko.observable(new Date)

		@header_date_format = 'MM yy'

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

		@days = ko.observableArray

		@gotoNextMonth = ->
			self.currentMonth(self.nextMonth())

		@gotoLastMonth = ->
			self.currentMonth(self.lastMonth())

window.CalendarViewModel = CalendarViewModel