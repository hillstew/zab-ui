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

  describe "instance-methods" do
    before(:each) do
      user = create(:user)
      @account_1 = create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user.id)
      @account_2 = create(:account, balance: 3409, interest_rate: 10, min_payment: 100, user_id: user.id)
      @account_3 = create(:account, balance: 12323, interest_rate: 10, min_payment: 150, user_id: user.id)
    end

    it '#total_months' do
      snowball = 550
      date = DateTime.new(2020, 1, 8)

      expect(@account_1.total_months(snowball, date)).to eq(4)
      @account_1.reload
      expect(@account_1.payoff_date).to eq('Apr 2020')
    end

    it '#snowball' do
      accounts = Account.all
      amount = 1000

      expect(@account_1.payoff_date).to be_nil

      accounts.snowball(amount)

      @account_1.reload
      @account_2.reload
      @account_3.reload

      expect(@account_1.count).to eq(DateTime.now.month + 3)
      expect(@account_2.snowball).to eq(750)
      expect(@account_3.snowball).to eq(850)
    end

    xit '#starting_total' do
      accounts = Account.all

      expect(accounts.starting_total).to eq(4.5)
    end

    xit '#paid_off_percentage' do

    end
  end
end
