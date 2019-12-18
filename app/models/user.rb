class User < ApplicationRecord
  has_many :accounts
  has_many :connections
  has_many :connected_users, through: :connections

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :budget_id
  validates_presence_of :token
  validates_presence_of :reminders?
  validates_presence_of :last_login
  validates_presence_of :monthly_payment
  validates :email, uniqueness: true, presence: true
end
