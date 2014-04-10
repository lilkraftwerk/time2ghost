class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :walk_speed
      t.string :phone_number
      t.string :email
    end
  end
end
