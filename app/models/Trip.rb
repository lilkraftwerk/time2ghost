class Trip < ActiveRecord::Base
  attr_accessible :user_id, :departure_station, :destination_station, :walking_time, :directions, :departure_time, :bart_line
  attr_accessor :current_location


end