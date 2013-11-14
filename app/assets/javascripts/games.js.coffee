
handleSearchGameKeypress = (event) ->
	$.getJSON

init = () ->
	$("#search-games").on 'keypress', handleSearchGameKeypress

games =
	init: init

window.kris =
	games: games