require 'test_helper'

class MovieTest < ActiveSupport::TestCase

	test "movie that starts with the word THE gets corrected" do
		movie = movies :one
		movie.title = "The Test Movie"

		assert movie.save, "could not save movie"
		assert_equal "Test Movie, The", movie.title
	end

end
