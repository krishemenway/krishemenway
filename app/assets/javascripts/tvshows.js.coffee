
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this
		@serieses = ko.observableArray(new SeriesViewModel series for series in serieses)

		@selectedSeries = ko.observable()

		@selectSeries = (series) ->
			self.selectedSeries(series)
		@clearSeries = ->
			self.selectedSeries(undefined)

class SeriesViewModel
	constructor: (series) ->
		self = this
		@name = series.name
		@id = series.id
		@seasons = ko.observableArray (new SeasonViewModel season, episodes for season, episodes of series.seasons)
		@selectedSeason = ko.observable()
		@selectSeason = (season) ->
			self.selectedSeason(season)

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

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel