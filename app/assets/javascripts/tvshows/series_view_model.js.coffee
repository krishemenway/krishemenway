
class SeriesViewModel
	constructor: (series) ->
		self = this

		self.name = series.name
		self.id = series.id

		self.slideImageLeft = series.slideImageLeft
		self.slideImageRight = series.slideImageRight

		self.selectedEpisode = ko.observable()

		self.selectEpisode = (episode) ->
			self.selectedEpisode(episode)

		self.seasons = ko.observableArray (new SeasonViewModel season, episodes for season, episodes of series.seasons)

		self.selectedSeason = ko.observable()

		self.hasSelectedSeason = ko.computed ->
			self.selectedSeason() != undefined

		self.hasSelectedEpisode = ko.computed ->
			self.selectedEpisode() != undefined

		self.selectSeason = (season) ->
			self.selectedSeason(season)

		self.clearSeries = () ->
			self.selectedSeason(undefined)
			self.selectedEpisode(undefined)

window.SeriesViewModel = SeriesViewModel