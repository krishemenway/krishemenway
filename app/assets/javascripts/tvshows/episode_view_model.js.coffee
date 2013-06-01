
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

		self._airdate = $.datepicker.parseDate('yy-mm-dd', episode.airdate)
		self.airdate = (format) ->
			$.datepicker.formatDate(format, self._airdate)

window.EpisodeViewModel = EpisodeViewModel