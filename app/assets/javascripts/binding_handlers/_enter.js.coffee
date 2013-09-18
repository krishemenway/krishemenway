ko.bindingHandlers.onEnter =
	init: (element, valueAccessor) ->
		$(element).on "keypress", (e) ->
			if (if e.keyCode then e.keyCode else e.which) == 13
				valueAccessor()(e)
