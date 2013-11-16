class String
	def to_bool
		parsedValue = self.downcase

		true_values = ["y", "true", "1"]
		false_values = ["n", "false", "0"]

		return true if true_values.include? parsedValue
		return false if false_values.include? parsedValue

		raise "Could not determine if it was true or false with #{string}"
	end

	def remove_leading_characters(n)
		self[n..self.length]
	end
end
