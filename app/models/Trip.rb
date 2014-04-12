class Trip < ActiveRecord::Base
  attr_accessible :user_id, :departure_station, :destination_station, :walking_time, :directions, :train_departing_time, :bart_line, :time_to_leave
  attr_accessor :current_location

  def update_departure_time
    depart_station_obj = get_station(self.departure_station)
    self.walking_time = get_walking_time_to_station(current_location, depart_station_obj.gmap_destination_string)

    depart_times = Bart.get_departures(self.departure_station, self.destination_station)
    self.bart_line = get_station(depart_times.pop).name

    depart_times.each do |depart_time|
      self.time_to_leave = depart_time.to_i - walking_time
      if time_to_leave >= 5
        self.train_departing_time = Time.now + depart_time.to_i
        break
      end
    end
  end

  def get_station(abbr)
    Station.find_by_abbr(abbr.upcase)
  end

  # def get_directions # not in mvp
  # end

  def get_walking_time_to_station(origin, destination)
    gmaps_json = GoogleMaps.http_get_directions(origin, destination)
    GoogleMaps.get_total_walking_time(gmaps_json)
  end

end