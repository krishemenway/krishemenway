
Date.parseFromServer = (dateToParse) ->
	dateParts = dateToParse.split("-")
	new Date(dateParts[0], dateParts[1] - 1, dateParts[2])
