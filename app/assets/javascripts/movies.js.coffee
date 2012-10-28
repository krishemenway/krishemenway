# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#movie-list li").hide().each (i, value) ->
		if i < 100
			$(value).delay(i * 40).fadeIn(600)
		else
			return