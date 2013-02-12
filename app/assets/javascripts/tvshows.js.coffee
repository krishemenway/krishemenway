
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this
		@series = ko.observableArray(new SeriesViewModel series for series in serieses)
		@currentSeries = ko.observable()
		@currentEpisode = ko.observable()

		@gotoSeries = (series) ->
			self.currentSeries(series)

		@gotoEpisode = (episode) ->
			self.currentEpisode(episode)

class SeriesViewModel
	constructor: (series) ->
		@name = series.name
		@id = series.id
		something = (new SeasonViewModel season, episodes for season, episodes of series.seasons)
		@seasons = ko.observableArray something

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
			return self.season + "x" + self.episode_in_season

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel