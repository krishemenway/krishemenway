
class LeaderboardViewModel
	constructor: (teams) ->
		self = this

		self.individualsLeaderboard = ko.observableArray()

		self.myTeamsLeaderboard = ko.observableArray()

		teamViewModels = (new TeamViewModel team for team in teams)
		self.teamsLeaderboard = ko.observableArray(teamViewModels)

class TeamViewModel
	constructor: (team) ->
		self = this

		self.name = team.name

		self.individuals = team.individuals

		self.individualsTotalScore = ko.observable()

window.LeaderboardViewModel = LeaderboardViewModel