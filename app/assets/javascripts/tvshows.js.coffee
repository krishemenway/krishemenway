
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this

		seriesViewModels = (
			for series, index in serieses
				side = if index % 2 == 0 then "right" else "left"
				new SeriesViewModel(series,side)
		)

		self.serieses = ko.observableArray(seriesViewModels)

		self.selectedSeries = ko.observable(undefined)

		self.selectSeries = (series) ->
			if self.selectedSeries() == series
				self.selectedSeries(undefined)
			else
				self.selectedSeries(series)
				self.selectedSeries().loadEpisodesIfNeccesary()
				window.scrollTo(0,0)

		self.clearSeries = ->
			self.selectedSeries().clearSeries()
			self.selectedSeries(undefined)


window.BrowseTVShowsViewModel = BrowseTVShowsViewModel