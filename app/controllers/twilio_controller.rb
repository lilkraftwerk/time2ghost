class TwilioController < ApplicationController
  def show
      first = ["RICH", "LAKE", "GLEN", "POWL", "FRMT", "MLBR", "LAFY", "DUBL", "CIVC", "BAYF", "COLS", "CAST", "SBRN"].sample
      second = ["RICH", "LAKE", "GLEN", "POWL", "FRMT", "MLBR", "LAFY", "DUBL", "CIVC", "BAYF", "COLS", "CAST", "SBRN"].sample

      bart = Bart.get_departures(first, second)
      bart.map!{|x| x + " minutes. "}
      @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']
      @client.account.messages.create(
       :from => '+14155211220',
       :to => '+18184212905',
       :body => "times from #{first} to #{second}: #{bart}"
      )
  end
end