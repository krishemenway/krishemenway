class Person < ActiveRecord::Base
  attr_accessible :dob, :first_name, :last_name, :worked_on_id, :worked_on_type
end
