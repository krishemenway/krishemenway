class Date
	def decade
		self.year - self.year % 10
	end
end
