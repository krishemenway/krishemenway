
class SeasonViewModel
	constructor: (season, episodes) ->
		self = this

		self.seasonNumber = season
		self.episodes = ko.observableArray(new EpisodeViewModel episode for episode in episodes)

window.SeasonViewModel = SeasonViewModel