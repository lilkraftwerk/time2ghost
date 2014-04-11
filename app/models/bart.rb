
class Bart
  def self.get_departures(origin, destination)
    route_number = self.get_correct_route(origin, destination)
    endpoint = self.get_endpoint_of_route(route_number[-1])
    realtime_departures = self.get_realtime_departures_on_route(origin, endpoint)
  end
  # gets the numbered BART route
  # between two stations
  # (ex: MLBR, POWL)

  def self.get_correct_route(origin, destination)
    our_route = HTTParty.get("http://api.bart.gov/api/sched.aspx?cmd=depart&orig=#{origin}&dest=#{destination}&key=MW9S-E7SL-26DU-VV8V")
    our_route = our_route["root"]["schedule"]["request"]["trip"].first["leg"]
    self.check_route(our_route)
  end

  def self.check_route(our_route)
    if our_route.is_a?(Array)
      final_route = our_route.first["line"]
    else
      final_route = our_route["line"]
    end
    final_route
  end
  # gets the endpoint of a route by number

  def self.get_endpoint_of_route(route_number)
    endpoint = HTTParty.get("http://api.bart.gov/api/route.aspx?cmd=routeinfo&route=#{route_number}&key=MW9S-E7SL-26DU-VV8V")
    endpoint["root"]["routes"]["route"]["config"]["station"].last
  end

  # gets the three closest departures from your origin station on the above route

  def self.get_realtime_departures_on_route(origin, endpoint)
    arrival_times = []
    request = HTTParty.get("http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{origin}&key=MW9S-E7SL-26DU-VV8V")
    lines = request["root"]["station"]["etd"]
    if lines.is_a?(Hash)
      lines["estimate"].each {|arrival| arrival_times << arrival["minutes"]}
    else
      new_lines = lines.select {|current_line| current_line["abbreviation"] == endpoint}.first
      if new_lines.nil?
        lines.first["estimate"].each {|arrival| arrival_times << arrival["minutes"]}
      else
        new_lines["estimate"].each {|arrival| arrival_times << arrival["minutes"]}
      end
    end
    arrival_times
  end
end