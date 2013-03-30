
class SeasonViewModel
	constructor: (season, episodes) ->
		@seasonNumber = season
		@episodes = ko.observableArray(new EpisodeViewModel episode for episode in episodes)

window.SeasonViewModel = SeasonViewModel