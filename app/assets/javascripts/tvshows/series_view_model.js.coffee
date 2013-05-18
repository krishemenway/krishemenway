
class SeriesViewModel
	constructor: (series, side) ->
		self = this

		self.side = side

		self.name = series.name
		self.id = series.id

		self.slideImageLeft = series.slideImageLeft
		self.slideImageRight = series.slideImageRight

		self.slideImage = ko.computed ->
			if self.side == "right" then self.slideImageRight else self.slideImageLeft

		self.hasSlideImage = ko.computed ->
			self.slideImage() != null

		self.seasons = ko.observableArray()

		self.loadEpisodes = (series) ->
			seasonViewModels = (new SeasonViewModel season, episodes for season, episodes of series.seasons)
			self.seasons(seasonViewModels)

		self.fetchEpisodes = () ->
			$.get('/tvshows/series/' + self.id, self.loadEpisodes)

		self.loadEpisodesIfNeccesary = () ->
			self.fetchEpisodes() if self.episodes().length == 0

		self.selectedEpisode = ko.observable()

		self.selectEpisode = (episode) ->
			self.selectedEpisode(episode)

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