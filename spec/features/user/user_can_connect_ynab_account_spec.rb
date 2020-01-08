require 'rails_helper'

RSpec.describe 'YNAB Connection' do
  it "I can connect my YNAB account" do
    user = create(:user, access_token: ENV['YNAB_TOKEN'], email: 'hill@hill.com', google_token: "123456789", reminders?: false)

    stub_request(:get, "#{ENV['ZAB_SERVICE_DOMAIN']}/api/v1/accounts/#{user.access_token}").
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
