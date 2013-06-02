
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

		self.advanceOnePageOfDays = () -> true

		self.reverseOnePageOfDays = () -> true

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

window.LoggedInIndividual = LoggedInIndividual