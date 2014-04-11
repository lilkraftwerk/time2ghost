class Bart
  require 'open-uri'

  def self.get_departures(origin, destination)
    route_xml = self.get_route_xml(origin, destination)
    route = parse_route_xml(route_xml)
    endpoint_xml = self.get_endpoint_xml(route)
    endpoint = self.parse_endpoint_xml(endpoint_xml)
    realtime_xml = self.get_realtime_departure_xml(origin, endpoint)
    self.parse_realtime_departure_xml(realtime_xml, endpoint)
  end

  def self.get_route_xml(origin, destination)
    open("http://api.bart.gov/api/sched.aspx?cmd=depart&orig=#{origin}&dest=#{destination}&key=MW9S-E7SL-26DU-VV8V") {|xml| xml.read }
  end

  def self.parse_route_xml(route_xml)
    Nokogiri::XML(route_xml).at_xpath('//leg').attributes["line"].value
  end

  def self.get_endpoint_xml(route_number)
    open("http://api.bart.gov/api/route.aspx?cmd=routeinfo&route=#{route_number[-1]}&key=MW9S-E7SL-26DU-VV8V") {|xml| xml.read }
  end

  def self.parse_endpoint_xml(endpoint_xml)
    Nokogiri::XML(endpoint_xml).at_xpath('//destination').content
  end

  def self.get_realtime_departure_xml(origin, endpoint)
    open("http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{origin}&key=MW9S-E7SL-26DU-VV8V") {|xml| xml.read }
  end

  def self.parse_realtime_departure_xml(realtime_xml, endpoint)
    path = Nokogiri::XML(realtime_xml).xpath('//etd')
    correct_destination = path.xpath("//abbreviation[contains(text(), '#{endpoint}')]").first.parent()
    arrival_times = []
    correct_destination.search('minutes').each {|x| arrival_times << x.text}
    arrival_times
  end
end