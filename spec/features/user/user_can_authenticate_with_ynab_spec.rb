require 'rails_helper'

RSpec.describe 'User Authentication' do
  describe 'When I visit the welcome page' do
    it "I see a Signup with YNAB button" do
      user = create(:user, access_token: ENV['YNAB_TOKEN'], email: 'hill@hill.com')

      stub_request(:get, "https://api.youneedabudget.com/v1/budgets/default/accounts").
        to_return(status: 200, body: File.read('./spec/fixtures/accounts_response.json'))

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit signup_accounts_path

      expect(page).to have_content("Gma")

      fill_in 'accounts[GMA][interest_rate]', with: 10

      fill_in 'accounts[GMA][min_payment]', with: 101

      find(:css, "#accounts_GMA_checked").set(true)

      expect(page).to have_content("Barclay")

      fill_in 'accounts[Barclay][interest_rate]', with: 12

      fill_in 'accounts[Barclay][min_payment]', with: 150

      find(:css, "#accounts_Barclay_checked").set(false)

      click_on 'Select'

      expect(current_path).to eq dashboard_path

    end
  end
end
