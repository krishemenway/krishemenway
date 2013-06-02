
class TeamViewModel
	constructor: (team) ->
		self = this

		self.name = team.name
		self.externalId = team.external_id

		self.members = ko.observableArray()
		self.membersAggregateScore = ko.observable(team.membersAggregateScore || 0)

		self.rank = ko.observable()

		self.sortMembersByRank = () ->
			self.members(self.members.sort (left, right) -> left.rank() - right.rank())

		self.recalculateScore = () ->
			totalScore = 0

			for member in self.members()
				totalScore += parseInt(member.score() || 0)

			self.membersAggregateScore(totalScore)

		self.addMember = (individualViewModel) ->
			self.members.push(individualViewModel)
			self.membersAggregateScore(self.membersAggregateScore() + individualViewModel.score())

window.TeamViewModel = TeamViewModel