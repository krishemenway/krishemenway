
class GenreFiltersViewModel
	constructor: (genres) ->
		self = this

		self.genres = (new GenreFilterViewModel g, self for g in genres)

		self.getSelected = ->
			return (self.genres.filter((genreViewModel) -> genreViewModel.isChecked()) || []).map (genre) ->
				return genre.id

		self.clearAll = ->
			g.isChecked(false) for g in self.genres

window.GenreFiltersViewModel = GenreFiltersViewModel