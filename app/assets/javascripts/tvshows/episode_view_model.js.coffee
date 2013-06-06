
class EpisodeViewModel
	constructor: (episode) ->
		self = this

		self.title = episode.title
		self.season = episode.season
		self.episodeInSeason = episode.episode_in_season
		self.episodeNumber = episode.episode_number
		self.seriesName = episode.series_name
		self.lastUpdate = episode.last_updated
		self.seasonPremiere = episode.episode_number == 1
		self.streamPath = episode.stream_path

		self._airdate = Date.parseFromServer(episode.airdate)

		self.airdate = (format) ->
			strftime(format, self._airdate)

window.EpisodeViewModel = EpisodeViewModel