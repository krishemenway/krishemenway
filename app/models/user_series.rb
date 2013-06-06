class UserSeries < ActiveRecord::Base
	attr_accessible :user_id, :series_id

	belongs_to :user
	belongs_to :series
end
