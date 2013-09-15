
class GenreViewModel
	constructor: (genre) ->
		self = this

		self.id = genre.id
		self.name = genre.name

window.GenreViewModel = GenreViewModel