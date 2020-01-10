require 'rails_helper'

RSpec.describe Dashboard::SnowballController, :type => :request do
  describe "GET #new " do
    it "snowball amount persists on page reload" do
      user = create(:user)
      create(:account, balance: 2345, interest_rate: 10, min_payment: 200, user_id: user.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get "#{ENV['REDIRECT_DOMAIN']}/snowball/1000"

      expect(response).to have_http_status(:success)
    end
  end
end
