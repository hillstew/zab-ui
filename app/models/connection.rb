class Connection < ApplicationRecord
  belongs_to :user
  belongs_to :connected_user, class_name: 'User'

  validates_presence_of :user_id
  validates_presence_of :connected_user_id
  validates_presence_of :accepted?
end
