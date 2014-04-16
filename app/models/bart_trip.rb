class BartTrip < ActiveRecord::Base
  attr_accessible :user_id, :departure_station, :destination_station, :walking_time, :directions,
  :train_departing_time, :bart_line, :recommended_leave_time, :current_location
  belongs_to :user
  include ApplicationHelper

  def update_departure_time
    set_walking_time
    get_depart_times_and_line
    get_minutes_until_train_departs
    set_train_departing_time
    set_recommended_leave_time
    self.save!
  end

  def get_walking_time_to_station(origin, destination)
    gmaps = GoogleMaps.new
    gmaps.http_get_directions(origin, destination)
    gmaps.get_total_walking_time
  end

  def valid?
    return false unless !self.current_location.blank?
    return false unless !self.departure_station.blank?
    return false unless !self.destination_station.blank?
    return false unless self.departure_station != self.destination_station
    true
  end

  def trip_message
    "Leave now to catch the #{format_time(self.train_departing_time)} #{self.bart_line} train " +
    "from #{Station.find_by_abbr(self.departure_station).name} to #{Station.find_by_abbr(self.destination_station).name}. It's a #{self.walking_time} minute walk. <3, time2ghost"
  end

  def self.get_trips_for_current_minute
    BartTrip.where("recommended_leave_time = ?", Time.now.change(:sec => 0))
  end

  def set_walking_time
    station_coordinates = Station.find_by_abbr(self.departure_station).gmap_destination_string
    self.walking_time = get_walking_time_to_station(current_location, station_coordinates)
  end

  def get_depart_times_and_line
    @realtime_departures = RealtimeBartDepartures.new(self.departure_station, self.destination_station).get_departures
    @realtime_departures
  end

  def get_minutes_until_train_departs
    puts @realtime_departures
    @first_possible_departure = @realtime_departures.find { |depart_time| (depart_time.first.to_i - self.walking_time - ADDITIONAL_MINUTES_FOR_TRIP) > 0 }
    if @first_possible_departure.nil?
      @first_possible_departure = @realtime_departures.last
    end
    set_bart_line
    set_minutes_until_next_train
  end

  def set_minutes_until_next_train
    @minutes_until_next_possible_train = @first_possible_departure.first if @first_possible_departure
  end

  def set_bart_line
    self.bart_line = Station.find_by_abbr(@first_possible_departure.pop).name if @first_possible_departure
  end

  def set_train_departing_time
    self.train_departing_time = remove_seconds_from_time(Time.now + @minutes_until_next_possible_train.minutes)
  end

  def set_recommended_leave_time
    self.recommended_leave_time = remove_seconds_from_time((Time.now + @minutes_until_next_possible_train.minutes) - ADDITIONAL_MINUTES_FOR_TRIP.minutes - self.walking_time.minutes)
  end


  def format_fake_trip(minutes_until_ghosting)
    @minutes_until_ghosting = minutes_until_ghosting.to_i.minutes
    set_walking_time
    format_fake_trip_minutes
  end

  def format_fake_trip_minutes
    fake_depart_time = remove_seconds_from_time(Time.now + @minutes_until_ghosting + number_to_minutes(self.walking_time) + ADDITIONAL_MINUTES_FOR_TRIP.minutes)
    self.update_attributes(:recommended_leave_time => remove_seconds_from_time(Time.now + @minutes_until_ghosting))
    self.update_attributes(:train_departing_time => fake_depart_time)
  end


end
