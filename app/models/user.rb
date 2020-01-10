class User < ApplicationRecord
  has_many :accounts
  has_many :connections
  has_many :connected_users, through: :connections

  validates_presence_of :google_token
  validates_presence_of :monthly_payment
  validates :email, uniqueness: true
end
