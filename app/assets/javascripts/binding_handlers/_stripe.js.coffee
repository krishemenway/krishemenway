ko.bindingHandlers.stripe =
	update: (element, valueAccessor, allBindingsAccessor) ->
		value = ko.utils.unwrapObservable(valueAccessor())
		allBindings = allBindingsAccessor()
		even = allBindings.evenClass
		odd = allBindings.oddClass

		$(element).children(":nth-child(odd)").addClass(odd).removeClass(even)
		$(element).children(":nth-child(even)").addClass(even).removeClass(odd)
