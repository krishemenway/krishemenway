
class DecadeFilterViewModel
	constructor: (decadesFromServer) ->
		self = this
		self.decades = (new DecadeViewModel decade, self for decade in decadesFromServer)

		self.getSelected = ->
			filteredDecades = self.decades.filter((letterViewModel) -> letterViewModel.isChecked())
			return if filteredDecades.length == 1 then filteredDecades[0].year else ''

		self.clearAll = ->
			decade.isChecked(false) for decade in self.decades

window.DecadeFilterViewModel = DecadeFilterViewModel