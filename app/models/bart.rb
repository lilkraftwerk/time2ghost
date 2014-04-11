class Bart
  def self.get_departures(origin, destination)
    route = self.get_correct_route(origin, destination)
    endpoint = self.get_endpoint(route)
    self.get_realtime_departures_on_route(origin, endpoint)
  end

  private

  def self.get_correct_route(origin, destination)
    raw_xml = open("http://api.bart.gov/api/sched.aspx?cmd=depart&orig=#{origin}&dest=#{destination}&key=MW9S-E7SL-26DU-VV8V") {|xml| xml.read }
    Nokogiri::XML(raw_xml).at_xpath('//leg').attributes["line"].value
  end

  def self.get_endpoint(route_number)
    endpoint = open("http://api.bart.gov/api/route.aspx?cmd=routeinfo&route=#{route_number[-1]}&key=MW9S-E7SL-26DU-VV8V") {|xml| xml.read }
    Nokogiri::XML(endpoint).at_xpath('//destination').content
  end

  def self.get_realtime_departures_on_route(origin, endpoint)
    puts "origin, endpoint: #{origin} / #{endpoint}"
    arrival_times = []
    realtime_xml = open("http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{origin}&key=MW9S-E7SL-26DU-VV8V") {|xml| xml.read }
    path = Nokogiri::XML(realtime_xml).xpath('//etd')
    correct_destination = path.xpath("//abbreviation[contains(text(), '#{endpoint}')]").first.parent()
    correct_destination.search('minutes').each {|x| arrival_times << x.text}
    arrival_times
  end
end
