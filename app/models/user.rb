class User < ApplicationRecord
  has_many :accounts
  has_many :connections
  has_many :connected_users, through: :connections

  validates_presence_of :access_token
  validates_presence_of :refresh_token
  # validates_presence_of :reminders?
  validates_presence_of :last_login
  validates_presence_of :monthly_payment
  # validates :email, uniqueness: true
end
