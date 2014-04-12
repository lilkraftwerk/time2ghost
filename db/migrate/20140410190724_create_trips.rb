class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :user
      t.string :departure_station
      t.string :destination_station
      t.integer :walking_time
      t.text :directions
      t.time :train_departing_time
      t.time :recommended_leave_time
      t.string :bart_line
      t.timestamps
    end
  end
end
