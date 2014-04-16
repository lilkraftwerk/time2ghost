require 'spec_helper'

describe BartTrip do
  before(:each) do
    @trip = BartTrip.new()
  end

  it "gets walking time to station" do
    origin = "633 folsom st, san francisco"
    destination = "37.789256,-122.401407"
    expect(@trip.get_walking_time_to_station(origin, destination)).to eq(8)
  end

  context "#remove_seconds_from_time" do
    it "removes seconds from a given time" do
      seconds = rand(60)
      time = Time.new(2013, 6, 29, 10, 15, seconds)
      expect(@trip.remove_seconds_from_time(time)).to eq("2013-06-29 10:15:00 -0700")
    end
  end

  context "#get_trips_for_current_minute" do
    it "finds accurate trips for current minute" do
    BartTrip.create(:recommended_leave_time => Time.now.change(:sec => 0))
    expect(BartTrip.get_trips_for_current_minute.length).to eq(1)
    end
  end
end