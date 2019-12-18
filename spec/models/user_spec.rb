require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:budget_id) }
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:last_login) }
    it { should validate_presence_of(:reminders?) }
    it { should validate_uniqueness_of(:email) }
  end 

  describe 'relationships' do
    it { should have_many(:accounts) }
    it { should have_many(:connections) }
    it { should have_many(:connected_users).through(:connections) }
  end
end
