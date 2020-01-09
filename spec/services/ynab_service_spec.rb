require 'rails_helper'

RSpec.describe 'YNAB Connection' do
  it 'can fetch tokens' do
    user = create(:user)
    code = 12345
    stub_request(:post, "https://app.youneedabudget.com/oauth/token?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}&redirect_uri=#{ENV['REDIRECT_DOMAIN']}/auth/ynab/callback&grant_type=authorization_code&code=#{code}").
      to_return(status: 200, body: File.read('./spec/fixtures/ynab_tokens.json'))

    service = YnabService.new(user)
    data = service.fetch_tokens(code)
    expect(data[:access_token]).to eq("b8583108e0b3225aa3d45ed14ffb2b18ca07270fda4559d617bc5e648f77ba63")
  end
end
