require 'spec_helper'
require 'fixtures/fixtures'

describe Bart do
  context "#parse_route_xml" do
    it "returns the correct route" do
      expect(Bart.parse_route_xml(ROUTE_XML)).to eq("ROUTE 2")
    end
  end

  context "#parse_endpoint_xml" do
    it "returns the correct endpoint" do
      expect(Bart.parse_endpoint_xml(ENDPOINT_XML)).to eq("SFIA")
      end
    end

  context "#parse_realtime_departure_xml" do
    it "returns realtime departure data" do
      expect(Bart.parse_realtime_departure_xml(REALTIME_XML, "DALY")).to eq(["11", "14", "25"])
    end
  end
end