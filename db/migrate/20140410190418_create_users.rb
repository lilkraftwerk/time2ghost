class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :walk_speed, default: "normal"
      t.string :phone_number
      t.string :email
      t.timestamps
    end
  end
end