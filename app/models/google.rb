class Google

  def self.get_directions(origin, destination)
    origin = origin.split(/[^\w-]+/).join("+")
    destination = destination.split(/[^\w-]+/).join("+")
    # Returns a json object
    directions = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&sensor=false&mode=walking")
    return directions
  end

  def self.get_location

  end

end


# Demo link
# https://maps.googleapis.com/maps/api/directions/json?origin=717+california+street&destination=montgomery+st+station&sensor=false&mode=walking