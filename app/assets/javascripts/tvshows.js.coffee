
class BrowseTVShowsViewModel
	constructor: (serieses) ->
		self = this
		@serieses = ko.observableArray(new SeriesViewModel series for series in serieses)

		@selectedSeries = ko.observable(undefined)

		@selectSeries = (series) ->
			self.selectedSeries(series)

		@clearSeries = ->
			self.selectedSeries(undefined)

		@isDoubleWide = ko.computed ->
			self.selectedSeries() != undefined and self.selectedSeries().hasSelectedEpisode()

		@selectedEpisode = ko.computed ->
			console.log self.selectedSeries().selectedEpisode() if self.selectedSeries() != undefined
			if self.selectedSeries() != undefined then self.selectedSeries().selectedEpisode() else undefined

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel