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
      it "successfully parses times for one endpoint" do
        departure_xml = Nokogiri::XML(REALTIME_XML).xpath('//etd')
        expect(BartXMLParser.parse_times_for_one_endpoint(departure_xml, "DALY").first.text).to eq("11")
      end
    end

  context "#parse_bart_stations_list" do
    it "successfully parses the list of stations" do
      expect(BartXMLParser.parse_bart_stations_list(STATION_XML).first.search('abbr')[0].text).to eq("12TH")
    end
  end

  context "#filter_realtime_departures_by_correct_route" do
    it "returns realtime departure data" do
      expect(BartXMLParser.filter_realtime_departures_by_correct_route(REALTIME_XML, ["DALY", "PITT"])).to eq([[6, "PITT"], [11, "DALY"], [14, "DALY"], [21, "PITT"], [25, "DALY"], [37, "PITT"]])
    end
  end
end

