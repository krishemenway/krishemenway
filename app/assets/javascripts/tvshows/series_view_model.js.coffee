
class SeriesViewModel
	constructor: (series, side) ->
		self = this

		self.side = side

		self.name = series.name
		self.id = series.id

		self.slideImageLeft = series.slideImageLeft
		self.slideImageRight = series.slideImageRight

		self.slideImage = ko.computed ->
			imageUrl = (if self.side == "right" then self.slideImageRight else self.slideImageLeft)
			if imageUrl == null then undefined else 'url('+imageUrl+')'

		self.hasSlideImage = ko.computed ->
			self.slideImage() != undefined

		self.seasons = ko.observableArray()

		self.loadEpisodes = (series) ->
			seasonViewModels = (new SeasonViewModel season, episodes for season, episodes of series.seasons)
			self.seasons(seasonViewModels)
			self.selectedSeason(seasonViewModels[0])

		self.fetchEpisodes = () ->
			$.getJSON "/tvshows/series/#{self.id}", self.loadEpisodes

		self.loadEpisodesIfNeccesary = () ->
			self.fetchEpisodes() if self.seasons().length == 0

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

		window.setTimeout( ->
			self.loadEpisodesIfNeccesary()
		, 10)

window.SeriesViewModel = SeriesViewModel