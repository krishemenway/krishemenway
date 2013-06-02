
class IndividualViewModel
	constructor: (individual) ->
		self = this

		self.name = individual.name
		self.score = ko.observable(individual.score || 0)
		self.teamId = individual.team_external_id

		self.daysEntered = 0

		self.rank = ko.observable()
		self.rankOnMyTeam = ko.observable()

window.IndividualViewModel = IndividualViewModel