
class AllTeamsLeaderboard
	constructor: (challenge) ->
		self = this

		self.pageSize = 10

		self.challenge = challenge

		self.leaderboardName = "all-teams"

		self.paginationEnabled = ko.computed ->
			self.challenge.teams().length > self.pageSize

		self.viewingIndex = ko.observable(0)

		self.viewableTeams = ko.computed ->
			self.challenge.teams.slice(self.viewingIndex(), self.viewingIndex() + self.pageSize)

		self.advanceOnePage = () ->
			newIndex = self.viewingIndex() + self.pageSize
			self.viewingIndex(if newIndex >= challenge.teams().length - self.pageSize then challenge.teams().length - self.pageSize else newIndex)

		self.reverseOnePage = () ->
			newIndex = self.viewingIndex() - self.pageSize
			self.viewingIndex(if newIndex <= 0 then 0 else newIndex)

window.AllTeamsLeaderboard = AllTeamsLeaderboard