class DateTime
	def in_pacific
		self.new_offset "-08:00"
	end
end