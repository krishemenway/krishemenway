class FixSlideImageRightName < ActiveRecord::Migration
	def self.up
		add_attachment :series, :slide_image_right
		remove_attachment :series, :slideImageRight
	end

	def self.down
		remove_attachment :series, :slide_image_right
		add_attachment :series, :slideImageRight
	end
end
