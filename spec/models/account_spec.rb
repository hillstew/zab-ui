require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:ynab_id) }
    it { should validate_presence_of(:starting_total) }
    it { should validate_presence_of(:interest_rate) }
    it { should validate_presence_of(:min_payment) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
  end
end
