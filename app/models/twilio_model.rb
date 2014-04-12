class TwilioModel
  def self.send_text(trip_object)
  @client = @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH'])
  bart_line = trip_object.bart_line
  station = Station.find_by_abbr(trip_object.departure_station).name
  depart_time = trip_object.train_departing_time.strftime("%l:%M")
  walking_time = trip_object.walking_time
  @client.account.messages.create(
    :from => '+14155211220',
    :to => "+1#{trip_object.user.phone_number}",
    :body => "Leave now to catch #{bart_line} train from #{station} at#{depart_time}. It's a #{walking_time} minute walk. <3, time2ghost"
)
  end

  def self.text_test
    @client = @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH'])
    @client.account.messages.create(
    :from => '+14155211220',
    :to => "+18184212905",
    :body => "hi it's #{Time.now}"
)
  end
end