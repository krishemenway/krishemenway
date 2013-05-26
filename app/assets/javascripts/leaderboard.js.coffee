
class LeaderboardViewModel
	constructor: (loggedInUsername) ->
		self = this

		self.individuals = ko.observableArray()

		self.reRankIndividuals = () ->
			sortedIndividuals = self.individuals.sort (left, right) ->
				return 0 if left.score() == right.score()
				return left.score() < right.score() ? 1 : -1

			self.individuals(sortedIndividuals)

		self.viewableIndividuals = ko.computed ->
			self.individuals.slice(0,10)

		self.loadIndividuals = (individuals) ->
			for individual in individuals
				indvidiaulViewModel = new IndividualViewModel(individual)
				self.individuals.push(indvidiaulViewModel)

			self.reRankIndividuals()

		$.get("/leaderboard/individuals", {}, self.loadIndividuals)

class TeamViewModel
	constructor: (team) ->
		self = this

		self.name = team.name

		self.teamMembers = team.individuals

		self.individualsTotalScore = ko.observable()

class IndividualViewModel
	constructor: (individual) ->
		self = this

		self.name = individual.name
		self.score = ko.observable(individual.score)

window.LeaderboardViewModel = LeaderboardViewModel