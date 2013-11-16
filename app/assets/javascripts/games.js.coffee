search_games = null
search_results = null

tryOneMoreTime = false
isQueryingServer = false

canQueryServer = (element) ->
	element.val().length > 1

handleSearchResponse = (response) ->
	search_results.html response

queryServerForResult = (value) ->
	$.get "/games/search/game", {query: value}, handleSearchResponse

handleSelectTag = (event) ->
	tag_name = $(event.currentTarget).data('tag-name')
	search_games.val('tag:' + tag_name)
	handleSearchGameKeypress()

handleSearchGameKeypress = () ->
	if canQueryServer(search_games)
		if !tryOneMoreTime and isQueryingServer
			tryOneMoreTime = true
		else
			queryServerForResult(search_games.val())

init = () ->
	search_results = $('#search_results')
	search_games = $('#search_games')
	$('.tags .tag').on 'click', handleSelectTag
	search_games.on 'keyup', handleSearchGameKeypress

games =
	init: init

window.kris =
	games: games