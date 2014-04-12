class TwilioModel
  def self.send_text(trip_object)
  @client = @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH'])
  @client.account.messages.create(
    :from => '+14155211220',
    :to => trip_object.user,
    :body => 'Hey there!'
)
end