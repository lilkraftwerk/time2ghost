# encoding: utf-8
require 'spec_helper'

  describe GoogleMaps do
    let!(:gmaps) { GoogleMaps.new }
    let!(:stubbed_json) {JSON.parse(IO.read("spec/stubbed_gmaps_response.json"))}
    it "returns correct walking time" do
      gmaps.parsed_response = stubbed_json
      walking_time = gmaps.get_total_walking_time
      expect(walking_time).to eq(9)
    end


    it "returns correct parsed walking directions array" do
      gmaps.parsed_response = stubbed_json
      directions = gmaps.parse_directions
      expected = ["Head <b>south</b> on <b>Grant Ave</b> toward <b>Vinton Ct</b>", "Turn <b>left</b> onto <b>Post St</b>", "Turn <b>right</b> onto <b>Montgomery St</b>", "Turn <b>left</b> onto <b>Market St</b>"]
      expect(directions).to eq(expected)
    end

    it "encodes params to direction url request" do
      origin = "633 Folsom st, san francisco"
      destination = "37.789256,-122.401407"
      expect(gmaps.assemble_directions_request(origin, destination)).to eq("https://maps.googleapis.com/maps/api/directions/json?origin=633+Folsom+st%2C+san+francisco&destination=37.789256%2C-122.401407&sensor=false&mode=walking")
    end
  end