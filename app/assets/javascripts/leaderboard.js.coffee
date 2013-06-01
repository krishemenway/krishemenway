
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

		self.fetchDataFromServer = () ->
			$.get("/leaderboard/individuals", {}, self.loadIndividuals)

		self.fetchDataFromServer()

class ChallengeSettings
	constructor: (settings) ->
		self = this

		self.programStartDate = new Date(settings.programStartDate)
		self.programEndDate = new Date(settings.programEndDate)

class LoggedInIndividual
	constructor: (challenge, individual) ->
		self = this

		self.individual = individual

		self.initializeDays = () ->
			currentTime = new Date

			for i in [0..5]
				date = new Date(currentTime.getTime());
				date.setDate(date.getDate() - i)
				self.days.push(new DayScoreViewModel(date))

		self.days = []

		self.viewableDays = ko.computed ->
			self.days

		self.advanceOnePageOfDays = () ->


		self.reverseOnePageOfDays = () ->


		self.updateScore = () ->
			totalScore = 0

			for day in self.days
				totalScore += parseInt(day.score() || 0)

			self.individual.score(totalScore)

			challenge.reRankIndividuals()
			challenge.myTeam.recalculateScore() if challenge.myTeam
			challenge.myTeam.sortMembersByRank() if challenge.myTeam
			challenge.reRankTeams()
			challenge.gotoMe()

		self.totalScore = ko.computed ->
			self.individual.score()

		self.initializeDays()

class DayScoreViewModel
	constructor: (date, score) ->
		self = this

		self.date = date
		self.score = ko.observable(score)

		self.keyPress = (model, event) ->
			event.which >= '0'.charCodeAt(0) and event.which <= '9'.charCodeAt(0)

		self.getDate = (format) ->
			$.datepicker.formatDate(format, self.date)

class TeamLeaderboard
	constructor: (challenge, team) ->
		self = this

		self.team = team

		self.challenge = challenge

		self.pageSize = 10

		self.viewingIndex = ko.observable(0)

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

class AllTeamsLeaderboard
	constructor: (challenge) ->
		self = this

		self.pageSize = 10

		self.challenge = challenge

		self.viewingIndex = ko.observable(0)

		self.viewableTeams = ko.computed ->
			challenge.teams.slice(self.viewingIndex(), self.viewingIndex() + self.pageSize)

		self.advanceOnePage = () ->
			newIndex = self.viewingIndex() + self.pageSize
			self.viewingIndex(if newIndex >= challenge.teams().length - self.pageSize then challenge.teams().length - self.pageSize else newIndex)

		self.reverseOnePage = () ->
			newIndex = self.viewingIndex() - self.pageSize
			self.viewingIndex(if newIndex <= 0 then 0 else newIndex)

class IndividualsLeaderboardViewModel
	constructor: (challenge) ->
		self = this

		self.pageSize = 10

		self.challenge = challenge

		self.viewingIndex = ko.observable(0)

		self.viewableIndividuals = ko.computed ->
			challenge.individuals.slice(self.viewingIndex(), self.viewingIndex() + self.pageSize)

		self.gotoMe = () ->
			newLocation = self.challenge.loggedInIndividual().individual.rank() - Math.floor(self.pageSize / 2)
			self.viewingIndex(if newLocation <= 0 then 0 else newLocation)

		self.advanceOnePage = () ->
			newIndex = self.viewingIndex() + self.pageSize
			self.viewingIndex(if newIndex >= challenge.individuals().length - self.pageSize then challenge.individuals().length - self.pageSize else newIndex)

		self.reverseOnePage = () ->
			newIndex = self.viewingIndex() - self.pageSize
			self.viewingIndex(if newIndex <= 0 then 0 else newIndex)

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

class IndividualViewModel
	constructor: (individual) ->
		self = this

		self.name = individual.name
		self.score = ko.observable(individual.score || 0)
		self.teamId = individual.team_external_id

		self.daysEntered = 0

		self.rank = ko.observable()
		self.rankOnMyTeam = ko.observable()

window.ChallengeViewModel = ChallengeViewModel