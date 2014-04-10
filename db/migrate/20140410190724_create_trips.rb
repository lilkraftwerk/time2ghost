class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :user
      t.string :departure_station
      t.string :destination
      t.time :walking_time
      t.time :departure_time
      t.string :bart_line
      t.timestamps
    end
  end
end
