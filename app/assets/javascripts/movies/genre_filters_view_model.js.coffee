
class GenreFiltersViewModel
	constructor: (genres, filterViewModel) ->
		self = this

		self.genres = ko.observableArray(new GenreFilterViewModel g, self, filterViewModel for g in genres)

		self.getSelected = ->
			return (self.genres().filter((genreViewModel) -> genreViewModel.isChecked()) || []).map (genre) ->
				return genre.id

		self.clearAll = ->
			genre.isChecked(false) for genre in self.genres()

window.GenreFiltersViewModel = GenreFiltersViewModel