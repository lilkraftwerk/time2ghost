class TwilioController < ApplicationController
  def show

      @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']
      @client.account.messages.create(
       :from => '+14155211220',
       :to => '+18184212905',
       :body => 'swag me out'
      )
  end
end