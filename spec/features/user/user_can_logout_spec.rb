require 'rails_helper'

RSpec.describe 'As a user' do
  it 'they can log out' do
    user = create(:user)
    account_1 = create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user.id)
    account_2 = create(:account, balance: 3409, interest_rate: 10, min_payment: 100, user_id: user.id)
    account_3 = create(:account, balance: 12323, interest_rate: 10, min_payment: 150, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_button 'Logout'

    expect(page).to have_button('Login with Google')
  end
end
