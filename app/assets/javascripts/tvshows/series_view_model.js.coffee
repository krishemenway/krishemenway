
class SeriesViewModel
	constructor: (series) ->
		self = this
		@name = series.name
		@id = series.id

		@selectedEpisode = ko.observable()

		@selectEpisode = (episode) ->
			self.selectedEpisode(episode)

		@seasons = ko.observableArray (new SeasonViewModel season, episodes for season, episodes of series.seasons)

		@selectedSeason = ko.observable()

		@hasSelectedSeason = ko.computed ->
			self.selectedSeason() != undefined

		@hasSelectedEpisode = ko.computed ->
			self.selectedEpisode() != undefined

		@selectSeason = (season) ->
			self.selectedSeason(season)

		@clearSeries = () ->
			self.selectedSeason(undefined)
			self.selectedEpisode(undefined)


window.SeriesViewModel = SeriesViewModel