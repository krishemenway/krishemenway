
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this
		self.serieses = ko.observableArray(new SeriesViewModel series for series in serieses)

		self.selectedSeries = ko.observable(undefined)

		self.selectSeries = (series) ->
			self.selectedSeries(series)

		self.clearSeries = ->
			self.selectedSeries().clearSeries()
			self.selectedSeries(undefined)

		self.isDoubleWide = ko.computed ->
			self.selectedSeries() != undefined and self.selectedSeries().hasSelectedEpisode()

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel