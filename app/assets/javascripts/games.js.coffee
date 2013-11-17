
class GamesViewModel
	constructor: () ->
		self = this
		isQueryingServer = false
		tryOneMoreTime = false

		self.recently_played = ko.observableArray()
		self.tags = ko.observableArray()

		self.search_results = ko.observableArray()
		self.search_query = ko.observable()
		self.last_searched_query = ""

		self.search_for_tag = (tag) ->
			console.log tag
			self.search_query("tag:" + tag.name)
			self.try_to_search()

		create_tags_from_server = (tags_json)  ->
			(new TagViewModel(tag) for tag in tags_json)

		create_games_from_server = (games_json) ->
			(new GameViewModel(game) for game in games_json)

		load_search_results = (games_from_server) ->
			isQueryingServer = false

			if tryOneMoreTime
				self.try_to_search()
			else
				self.search_results(create_games_from_server(games_from_server))

		can_search = () ->
			self.search_query().length >= 2 or self.last_searched_query != self.search_query()

		self.try_to_search = () ->
			unless can_search()
				return

			if isQueryingServer
				tryOneMoreTime = true
			else
				$.getJSON "/games/search/game", { query: self.search_query() }, load_search_results

		self.init = (recently_played_games_from_server, initial_search_results_from_server, tags_from_server) ->
			self.recently_played(create_games_from_server(recently_played_games_from_server))
			self.search_results(create_games_from_server(initial_search_results_from_server))
			self.tags(create_tags_from_server(tags_from_server))

		return self

class GameViewModel
	constructor: (game_json) ->
		self = this

		self.name = game_json.name
		self.app_id = game_json.app_id
		self.image_path = game_json.image_path
		self.run_app_url = game_json.run_url

		return self

class TagViewModel
	constructor: (tag_json) ->
		self = this

		self.name = tag_json.name
		self.example_one = new GameViewModel(tag_json.example_one)
		self.example_two = new GameViewModel(tag_json.example_two)
		self.examples = [self.example_one, self.example_two]

		return self

window.GamesViewModel = GamesViewModel