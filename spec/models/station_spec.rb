require 'spec_helper'

describe Station do

  let!(:station) {Station.find_by_abbr("MONT")}

  context "#distance_to" do

    it "gives correct lat&long difference for provided lat&long" do
      expect(station.distance_to(37.792197, -122.406146)).to eq(0.007680000000000575)
    end

  end

  context "#gmap_destination_string" do

    it "returns the correct lat&long of station in string form" do
      expect(station.gmap_destination_string).to eq("37.789256,-122.401407")
    end

  end

end