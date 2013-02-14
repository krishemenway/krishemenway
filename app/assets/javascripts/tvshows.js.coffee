
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this
		@series = ko.observableArray(new SeriesViewModel series for series in serieses)

		@selectedSeason = ko.observable()
		@gotoSeason = (season) ->
			self.selectedSeason(season)
		@clearSeason = ->
			self.selectedSeason(undefined)

class SeriesViewModel
	constructor: (series) ->
		self = this
		@name = series.name
		@id = series.id
		@seasons = ko.observableArray (new SeasonViewModel season, episodes for season, episodes of series.seasons)
		@isOpen = ko.observable(false)
		@toggleOpen = ->
			if self.isOpen() then self.isOpen(false) else self.isOpen(true)


class SeasonViewModel
	constructor: (season, episodes) ->
		@season_number = season
		@episodes = ko.observableArray(new EpisodeViewModel episode for episode in episodes)


class EpisodeViewModel
	constructor: (episode) ->
		self = this
		@title = episode.title
		@season = episode.season
		@episode_in_season = episode.episode_in_season
		@episode_number = episode.episode_number
		@series_name = episode.series_name
		@airdate = episode.airdate

		@episodeNumber = ko.computed ->
			return 's' + self.season + "e" + self.episode_in_season

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel