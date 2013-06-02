
class IndividualsLeaderboardViewModel
	constructor: (challenge) ->
		self = this

		self.pageSize = 10

		self.challenge = challenge

		self.viewingIndex = ko.observable(0)

		self.leaderboardName = "individuals"

		self.paginationEnabled = ko.computed ->
			self.challenge.individuals().length > self.pageSize

		self.viewableIndividuals = ko.computed ->
			self.challenge.individuals.slice(self.viewingIndex(), self.viewingIndex() + self.pageSize)

		self.gotoMe = () ->
			newLocation = self.challenge.loggedInIndividual().individual.rank() - Math.floor(self.pageSize / 2)
			self.viewingIndex(if newLocation <= 0 then 0 else newLocation)

		self.advanceOnePage = () ->
			newIndex = self.viewingIndex() + self.pageSize
			self.viewingIndex(if newIndex >= challenge.individuals().length - self.pageSize then challenge.individuals().length - self.pageSize else newIndex)

		self.reverseOnePage = () ->
			newIndex = self.viewingIndex() - self.pageSize
			self.viewingIndex(if newIndex <= 0 then 0 else newIndex)

window.IndividualsLeaderboardViewModel = IndividualsLeaderboardViewModel