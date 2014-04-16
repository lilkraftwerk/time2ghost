require 'spec_helper'
require 'fixtures/fixtures'

describe BartXMLParser do
  context "#get_route_numbers_from_xml" do
    it "returns the correct route" do
      expect(BartXMLParser.get_route_numbers_from_xml(ROUTE_XML)).to eq(["8", "12", "2", "6"])
    end
  end

  context "#get_name_of_endpoint_station" do
    it "returns the correct endpoint" do
      expect(BartXMLParser.get_name_of_endpoint_station(ENDPOINT_XML)).to eq("SFIA")
      end
    end

    context "#parse_times_for_one_endpoint" do
      xit "successfully parses times for one endpoint" do

      end
    end

  context "#parse_bart_stations_list" do
    xit "successfully parses the list of stations" do

    end
  end

  context "#filter_realtime_departures_by_correct_route" do
    it "returns realtime departure data" do
      expect(BartXMLParser.filter_realtime_departures_by_correct_route(REALTIME_XML, "DALY")).to eq(["11", "14", "25"])
    end
  end
end

