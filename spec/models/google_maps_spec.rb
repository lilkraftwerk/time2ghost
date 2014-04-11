# encoding: utf-8
require 'spec_helper'

  describe GoogleMaps do
    let!(:stubbed_response) { JSON.parse(IO.read("spec/stubbed_gmaps_response.json")) }

    it "returns correct walking time" do
      walking_time = GoogleMaps.get_total_walking_time(stubbed_response)
      expect(walking_time).to eq("9 mins")
    end


    it "returns correct walking directions array" do
      directions = GoogleMaps.parse_directions(stubbed_response)
      expected = ["Head <b>south</b> on <b>Grant Ave</b> toward <b>Vinton Ct</b>", "Turn <b>left</b> onto <b>Post St</b>", "Turn <b>right</b> onto <b>Montgomery St</b>", "Turn <b>left</b> onto <b>Market St</b>"]
      expect(directions).to eq(expected)
    end


  end