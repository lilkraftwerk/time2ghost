require 'spec_helper'

describe Trip do
  let(:trip) { Trip.new }

  it "finds the Powell station as closest to specified coords" do
    station = trip.find_closest_station(37.779178, -122.406220)
    expect(station.abbr).to eq("POWL")
  end

  it "find the Montgomery station as closest to specified coords" do
    station = trip.find_closest_station(37.792237, -122.406163)
    expect(station.abbr).to eq("MONT")
  end

end