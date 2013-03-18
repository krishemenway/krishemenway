
class SeasonViewModel
	constructor: (season, episodes) ->
		@seasonNumber = season
		@episodes = ko.observableArray(new EpisodeViewModel episode for episode in episodes)
		@isSelected = ko.observable(false)

window.SeasonViewModel = SeasonViewModel