
class GamesViewModel
	constructor: () ->
		self = this
		isQueryingServer = false
		tryOneMoreTime = false
		last_searched_query = ""

		self.recently_played = ko.observableArray()
		self.tags = ko.observableArray()

		self.search_results = ko.observableArray()
		self.search_query = ko.observable()
		self.selected_game = ko.observable()

		clear_search = () ->
			self.search_results([])
			self.search_query("")

		create_tags_from_server = (tags_json)  ->
			(new TagViewModel(tag) for tag in tags_json)

		create_games_from_server = (games_json) ->
			(new GameViewModel(game) for game in games_json)

		load_search_results = (games_from_server) ->
			isQueryingServer = false

			if tryOneMoreTime
				self.try_to_search()
			else
				self.selected_game(null)
				self.search_results(create_games_from_server(games_from_server))

		can_search = () ->
			self.search_query().length >= 2 and last_searched_query != self.search_query()

		self.open_profile = (game) ->
			self.selected_game(game)
			self.selected_game().fetch_and_load_tags()
			clear_search()

		self.search_for_tag = (tag) ->
			self.search_query("tag:" + tag.name)
			self.try_to_search()

		self.try_to_search = () ->
			unless can_search()
				return

			if isQueryingServer
				tryOneMoreTime = true
			else
				$.getJSON "/games/search/game", { query: self.search_query() }, load_search_results
				last_searched_query = self.search_query()

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
		self.run_url = game_json.run_url

		self.tags = ko.observableArray()

		self.new_tag_name = ko.observable()

		self.load_tags = (response) ->
			tags = (new TagViewModel(tag) for tag in response)
			self.tags(tags)

		self.fetch_and_load_tags = () ->
			$.getJSON '/games/game/tags', {app_id: self.app_id}, self.load_tags

		self.handle_successful_add = (response) ->
			self.tags.push(new TagViewModel(response))

		self.add_tag = () ->
			$.post '/games/game/tag_game', {app_id: self.app_id, tag_name: self.new_tag_name()}, self.handle_successful_add
			self.new_tag_name('')

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