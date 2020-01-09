require 'rails_helper'

RSpec.describe 'As a logged in user' do
  xit "snowball amount persists on page reload" do
    user = create(:user)
    account_1 = create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user.id)
    account_2 = create(:account, balance: 3409, interest_rate: 10, min_payment: 100, user_id: user.id)
    account_3 = create(:account, balance: 12323, interest_rate: 10, min_payment: 150, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_css('#snowball-input')

    fill_in 'snowball', with: 1000

    click_button 'Calculate'

    visit dashboard_path

    account_1.reload

    expect(account_1.snowball).to eq(550)
    # within "#account-#{account_1.id}" do
    #   expect(page).to have_content(550)
    # end
  end
end
