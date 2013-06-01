ko.bindingHandlers.spinning_number_text =
	update: (element, valueAccessor, allBindingsAccessor) ->
		value = ko.utils.unwrapObservable(valueAccessor())

		from =
			number: parseInt($(element).html())
		to =
			number: parseInt(value)

		animateOptions =
			duration: 500
			step: -> $(element).text(Math.ceil(this.number))
			complete: -> $(element).text(value)

		$(from).animate(to, animateOptions)