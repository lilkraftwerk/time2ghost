require 'spec_helper'
require 'fixtures/fixtures'

describe RealtimeBartDepartures do
  context "#get_departures" do
    it "successfully gets realtime departures" do
      @departures = RealtimeBartDepartures.new("POWL", "MONT").get_departures
      expect(@departures.first[0]).to be_a(Integer)
      expect(@departures.first[1]).to be_a(String)
    end
  end
end