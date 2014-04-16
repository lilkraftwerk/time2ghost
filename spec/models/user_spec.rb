require 'spec_helper'

describe User do

  let!(:user) { User.create(username: "doge", password: "password", email: "doge@doge.doge", phone_number: "1234567890") }

  context "#user" do
    it "returns formatted phone_number" do
      expect(user.format_phone_number).to eq("(123) 456-7890")
    end

    it "finds future trips" do
      trip = user.bart_trips.create(departure_station: "MONT", destination_station: "PITT", current_location: "717 california st, san francicsco", recommended_leave_time: Time.now + 5.minutes)
      expect(user.trips_in_the_future.first).to eq(trip)
    end
  end

end