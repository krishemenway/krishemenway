#= require application

class BrowseTVShowsViewModel
	constructor: (series) ->
		@series = ko.observableArray(new SeriesViewModel s for s in series)

class SeriesViewModel
	constructor: (series) ->
		@name = series.name
		@episodes = ko.observableArray()

window.BrowseTVShowsViewModel = BrowseTVShowsViewModel