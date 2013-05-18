
class FrontPageViewModel
	constructor: (events_by_date, latest_episodes) ->
		self = this

		self.days = ko.observableArray()
		self.latest_episodes = ko.observableArray()

		self.addLatestEpisode = (episode) ->
			@latest_episodes.push new EpisodeViewModel(episode)

		self.loadEventsForDay = (day, events) ->
			date = $.datepicker.parseDate('yy-mm-dd', day)
			@days.push new DayViewModel(date, events)

		self.addLatestEpisode episode for episode in latest_episodes
		self.loadEventsForDay date, events for date,events of events_by_date

window.FrontPageViewModel = FrontPageViewModel