class Station < ActiveRecord::Base
  attr_accessible :name, :abbr, :latitude, :longitude,
  :address, :city, :state, :zipcode
end