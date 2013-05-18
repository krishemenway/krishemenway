class AddImagesToSeries < ActiveRecord::Migration
	def change
		change_table :series do |t|
			t.has_attached_file :slide_image_left
			t.has_attached_file :slideImageRight
		end
	end
end
