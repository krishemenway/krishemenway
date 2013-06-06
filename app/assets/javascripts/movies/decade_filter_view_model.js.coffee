
class DecadeFilterViewModel
	constructor: (decades, filterViewModel) ->
		self = this
		self.decades = ko.observableArray(new DecadeViewModel decade, self, filterViewModel for decade in decades)

		self.getSelected = ->
			decades = self.decades().filter((letterViewModel) -> letterViewModel.isChecked())
		return if decades.length == 0 then "" else decades[0].year

		self.clearAll = ->
			decade.isChecked(false) for decade in self.decades()

window.DecadeFilterViewModel = DecadeFilterViewModel