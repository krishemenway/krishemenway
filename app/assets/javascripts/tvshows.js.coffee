
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this

		seriesViewModels = (
			for series in serieses
				side = if _i % 2 == 0 then "right" else "left"
				new SeriesViewModel(series,side)
		)

		self.serieses = ko.observableArray(seriesViewModels)

		self.selectedSeries = ko.observable(undefined)

		self.selectSeries = (series) ->
			self.selectedSeries(if self.selectedSeries() == series then undefined else series)
			self.selectedSeries().loadEpisodesIfNeccesary()

		self.clearSeries = ->
			self.selectedSeries().clearSeries()
			self.selectedSeries(undefined)


window.BrowseTVShowsViewModel = BrowseTVShowsViewModel