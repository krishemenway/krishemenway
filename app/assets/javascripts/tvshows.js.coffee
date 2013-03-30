
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this
		@serieses = ko.observableArray(new SeriesViewModel series for series in serieses)

		@selectedSeries = ko.observable(undefined)

		@selectSeries = (series) ->
			self.selectedSeries(series)

		@clearSeries = ->
			self.selectedSeries().clearSeries()
			self.selectedSeries(undefined)

		@isDoubleWide = ko.computed ->
			self.selectedSeries() != undefined and self.selectedSeries().hasSelectedEpisode()

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel