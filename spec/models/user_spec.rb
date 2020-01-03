require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:access_token) }
    # it { should validate_presence_of(:refresh_token) }
    it { should validate_presence_of(:google_token) }
    # it { should validate_presence_of(:last_login) }
    # it { should validate_presence_of(:reminders?) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'relationships' do
    it { should have_many(:accounts) }
    it { should have_many(:connections) }
    it { should have_many(:connected_users).through(:connections) }
  end
end
