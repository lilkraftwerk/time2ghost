class GoogleMaps
  require 'uri'

  def self.http_get_directions(origin, destination)
    url = self.assemble_directions_request(origin, destination)

    HTTParty.get(url).parsed_response
  end

  def self.get_total_walking_time(json_object)
    json_object["routes"][0]["legs"][0]["duration"]["text"]
  end

  def self.parse_directions(json_object)
    directions = []
    json_object["routes"][0]["legs"][0]["steps"].each do |step|
      directions << step["html_instructions"]
    end

    directions
  end

  private
  def self.assemble_directions_request(origin, destination)
    params = {
      :origin => origin,
      :destination => destination,
      :sensor => false,
      :mode => "walking"
    }

    "https://maps.googleapis.com/maps/api/directions/json?" + URI.encode_www_form(params)
  end

end


# Demo link
# https://maps.googleapis.com/maps/api/directions/json?origin=717+california+street&destination=montgomery+st+station&sensor=false&mode=walking