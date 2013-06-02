
class ChallengeViewModel
	constructor: (settings) ->
		self = this

		self.settings = new ChallengeSettings(settings)

		self.individuals = ko.observableArray()
		self.teams = ko.observableArray()
		self.teamsByExternalId = {}

		self.loggedInIndividual = ko.observable()
		self.individualLeaderboard = new IndividualsLeaderboardViewModel(self)
		self.teamsLeaderboard = new AllTeamsLeaderboard(self)

		self.myTeam = undefined
		self.myTeamLeaderboard = ko.observable()

		self.selectMyTeamLeaderboard = () ->
			self.selectLeaderboard(self.myTeamLeaderboard())

		self.selectIndividualLeaderboard = () ->
			self.selectLeaderboard(self.individualLeaderboard)

		self.selectTeamsLeaderboard = () ->
			self.selectLeaderboard(self.teamsLeaderboard)

		self.selectLeaderboard = (leaderboard) ->
			self.selectedLeaderboard(leaderboard)

		self.selectedLeaderboard = ko.observable()
		self.selectIndividualLeaderboard()

		self.selectedLeaderboardClass = ko.computed ->
			self.selectedLeaderboard().leaderboardName + '-selected'

		self.gotoMe = () ->
			self.individualLeaderboard.gotoMe()
			self.myTeamLeaderboard().gotoMe() if self.myTeamLeaderboard() != undefined

		self.reRankTeams = () ->
			sortedTeams = self.teams.sort (left, right) -> right.membersAggregateScore() - left.membersAggregateScore()
			team.rank(i + 1) for team, i in sortedTeams

			self.teams(sortedTeams)

		self.reRankIndividuals = () ->
			sortedIndividuals = self.individuals.sort (left, right) -> right.score() - left.score()
			individual.rank(i + 1) for individual, i in sortedIndividuals

			self.individuals(sortedIndividuals)

		self.loadIndividuals = (individualsResult) ->
			loggedInName = individualsResult.logged_in_user

			for team in individualsResult.teams
				teamViewModel = new TeamViewModel(team)
				self.teamsByExternalId[teamViewModel.externalId] = teamViewModel
				self.teams.push(teamViewModel)

			for individual in individualsResult.individuals
				individualViewModel = new IndividualViewModel(individual)
				self.individuals.push(individualViewModel)
				self.teamsByExternalId[individualViewModel.teamId].addMember(individualViewModel)

				if individualViewModel.name == loggedInName
					self.loggedInIndividual(new LoggedInIndividual(self, individualViewModel))
					self.myTeam = self.teamsByExternalId[individualViewModel.teamId]
					self.myTeamLeaderboard(new TeamLeaderboard(self, self.myTeam))

			self.reRankIndividuals()
			self.reRankTeams()
			self.gotoMe()

		self.fetchDataFromServer = () ->
			$.get("/leaderboard/individuals", {}, self.loadIndividuals)

		self.fetchDataFromServer()

class ChallengeSettings
	constructor: (settings) ->
		self = this

		self.programStartDate = new Date(settings.programStartDate)
		self.programEndDate = new Date(settings.programEndDate)

window.ChallengeViewModel = ChallengeViewModel