
class TeamLeaderboard
	constructor: (challenge, team) ->
		self = this

		self.team = team

		self.challenge = challenge

		self.leaderboardName = "team"

		self.pageSize = 10

		self.viewingIndex = ko.observable(0)

		self.paginationEnabled = ko.computed ->
			self.team.members().length > self.pageSize

		self.viewableIndividuals = ko.computed ->
			self.team.members.slice(self.viewingIndex(), self.viewingIndex() + self.pageSize)

		self.advanceOnePage = () ->
			newIndex = self.viewingIndex() + self.pageSize
			self.viewingIndex(if newIndex >= self.team.members().length - self.pageSize then self.team.members().length - self.pageSize else newIndex)

		self.reverseOnePage = () ->
			newIndex = self.viewingIndex() - self.pageSize
			self.viewingIndex(if newIndex <= 0 then 0 else newIndex)

		self.gotoMe = () ->
			newLocation = self.team.members.indexOf(self.challenge.loggedInIndividual().individual) - Math.floor(self.pageSize / 2) + 1
			self.viewingIndex(if newLocation <= 0 then 0 else newLocation)

window.TeamLeaderboard = TeamLeaderboard