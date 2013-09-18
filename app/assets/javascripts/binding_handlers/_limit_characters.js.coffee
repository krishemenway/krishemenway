ko.bindingHandlers.limitCharacters =
	init: (element, valueAccessor, allBindingsAccessor) ->

		startCharCode = 'A'.charCodeAt(0)
		endCharCode = 'z'.charCodeAt(0)

		$(element).on 'keydown', (e) ->
			key = if e.keyCode then e.keyCode else e.which
			isSpecialCharacter = key < startCharCode or key > endCharCode
			return isSpecialCharacter || element.value.length < ko.utils.unwrapObservable(valueAccessor())