
class DecadeFilterViewModel
	constructor: (decadesFromServer) ->
		self = this
		self.decades = (new DecadeViewModel decade, self for decade in decadesFromServer)

		self.selectedDecade = ko.observable(undefined)

		self.selectDecade = (targetDecade) ->
			newDecade = if self.selectedDecade() == targetDecade then undefined else targetDecade
			self.selectedDecade(newDecade)
			self.toggleViewingDecades()

		self.getSelectedDecade = () ->
			return if self.selectedDecade() != undefined then self.selectedDecade().year else ''

		self.decadeListVisible = ko.observable(false)

		self.toggleViewingDecades = () ->
			self.decadeListVisible(!self.decadeListVisible())

		self.clearAll = ->
			decade.isChecked(false) for decade in self.decades

window.DecadeFilterViewModel = DecadeFilterViewModel