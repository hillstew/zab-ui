require 'rails_helper'

RSpec.describe 'As a user' do
  xit 'they can log in' do
    WebMock.enable_net_connect!
    user_1 = create(:user, email:"gthompson@fastmail.com", first_name: "Graham", last_name: "Thompson", google_token: ENV["GOOGLE_TEST_TOKEN"])
    create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user_1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit welcome_path

    click_button 'Login with Google'

    stub_request(:get, "#{ENV['ZAB_SERVICE_DOMAIN']}/api/v1/accounts/#{user_1.access_token}").
      to_return(status: 200, body: File.read('./spec/fixtures/accounts_response.json'))

    expect(current_path).to eq(accounts_update_path)
  end

  it 'they are directed to signup accounts page if they do not have YNAB accounts' do
    create(:user)

    visit welcome_path

    click_button 'Login with Google'

    visit welcome_path

    click_button 'Login with Google'

    expect(current_path).to eq(signup_ynab_path)
  end

  xit 'they are redirected to dashboard page ' do
    WebMock.enable_net_connect!
    user_1 = create(:user, email:"gthompson@fastmail.com", first_name: "Graham", last_name: "Thompson", google_token: ENV["GOOGLE_TEST_TOKEN"])
    create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user_1.id)

    visit welcome_path

    click_button 'Login with Google'

    stub_request(:get, "#{ENV['ZAB_SERVICE_DOMAIN']}/api/v1/accounts/#{user_1.access_token}").
      to_return(status: 200, body: File.read('./spec/fixtures/accounts_response.json'))

    expect(current_path).to eq(accounts_update_path)
  end

  it 'they can log out' do
    user_1 = create(:user, email:"gthompson@fastmail.com", first_name: "Graham", last_name: "Thompson", google_token: ENV["GOOGLE_TEST_TOKEN"])

    create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user_1.id)
    create(:account, balance: 3409, interest_rate: 10, min_payment: 100, user_id: user_1.id)
    create(:account, balance: 12323, interest_rate: 10, min_payment: 150, user_id: user_1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    click_button 'Logout'

    expect(page).to have_button('Login with Google')
  end
end
