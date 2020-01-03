require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'I can authenticate with Google' do
    visit welcome_path

    click_link 'Login with Google'

    user = User.last

    expect(user.first_name).to eq("Graham")
    expect(user.last_name).to eq("Thompson")
    expect(user.email).to eq("gthompson@fastmail.com")
    expect(user.google_token).to eq(ENV['GOOGLE_TEST_TOKEN'])

    expect(current_path).to eq signup_ynab_path
  end
end
