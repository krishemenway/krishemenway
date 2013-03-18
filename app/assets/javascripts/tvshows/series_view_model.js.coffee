
class SeriesViewModel
	constructor: (series) ->
		self = this
		@name = series.name
		@id = series.id

		@selectEpisode = (episode) ->
			return undefined if self.selectedSeason() == undefined
			episode.isSelected(true)
			e.isSelected(false) for e in self.selectedSeason()

		@selectedEpisode = () ->
			return undefined if self.selectedSeason() == undefined
			episodes = (episode for episode in self.selectedSeason().episodes() when episode.isSelected())
			return if episodes.length > 0 then episodes[0] else undefined

		@selectedSeason = () ->
			selectedSeasons = (season for season in self.seasons() when season.isSelected())
			return if selectedSeasons.length > 0 then selectedSeasons[0] else undefined

		@seasons = ko.observableArray (new SeasonViewModel season, episodes for season, episodes of series.seasons)

		@hasSelectedSeason = ko.computed ->
			self.selectedSeason() != undefined

		@hasSelectedEpisode = ko.computed ->
			self.selectedEpisode() != undefined

		@clearSelectedSeason = () ->
			s.isSelected(false) for s in self.seasons()

		@selectSeason = (season) ->
			self.clearSelectedSeason()
			season.isSelected(true)

window.SeriesViewModel = SeriesViewModel