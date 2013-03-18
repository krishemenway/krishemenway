
class EpisodeViewModel
	constructor: (episode) ->
		self = this

		@title = episode.title
		@season = episode.season
		@episodeInSeason = episode.episode_in_season
		@episodeNumber = episode.episode_number
		@seriesName = episode.series_name
		@lastUpdate = episode.last_updated
		@seasonPremiere = episode.episode_number == 1

		@_airdate = $.datepicker.parseDate('yy-mm-dd', episode.airdate)
		@airdate = (format) ->
			$.datepicker.formatDate(format, self._airdate)

		@isSelected = ko.observable(false)

window.EpisodeViewModel = EpisodeViewModel