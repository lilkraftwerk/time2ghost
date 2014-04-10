class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :walk_speed, :phone_number, :email, :password
  validates :username, presence: :true, uniqueness: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :password, length: { in: 6..30 }
end