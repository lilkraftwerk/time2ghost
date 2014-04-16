require 'spec_helper'
require 'fixtures/fixtures'

describe ApplicationHelper do

  context "#display_station_name" do
    it "successfully displays a station name" do
      expect(display_station_name("POWL")).to eq("Powell St.")
    end
  end

  context "#number_to_minutes" do
    it "converts a number into minutes" do
      expect(number_to_minutes(5)).to eq(5.minutes)
    end
  end
end