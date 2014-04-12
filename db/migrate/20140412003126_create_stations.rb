class CreateStations < ActiveRecord::Migration
def change
    create_table :stations do |t|
      t.string :abbr
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.timestamps
    end
  end
end
