class GoogleJson
  def self.get_walking_time(json_object)
    time = json_object["routes"][0]["legs"][0]["duration"]["text"]
    return time
  end

  def self.get_directions(json_object)

  end



end