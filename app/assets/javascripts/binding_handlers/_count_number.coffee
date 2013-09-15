countNumber = (element, from, to, duration) ->
	current = from
	numberOfIncrements = duration / 37
	incrementAmount = (to - from) / numberOfIncrements

	setValueToElement = (value) ->
		element.innerHTML = value

	animateNumberIteration = () ->
		current += incrementAmount
		setValueToElement(Math.floor(current))

		if --numberOfIncrements >= 0
			window.setTimeout(animateNumberIteration, 37)
		else
			setValueToElement(to)

	window.setTimeout(animateNumberIteration, 37)

ko.bindingHandlers.countNumber =

	init: (element) ->
		element.currentValue = 0

	update: (element, valueAccessor) ->
		value = ko.unwrap(valueAccessor())
		from = parseInt($(element).html(), 10)
		to = parseInt(value, 10)
		countNumber(element, from, to, 400)