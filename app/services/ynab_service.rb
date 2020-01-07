class YnabService
  def initialize(user)
    @current_user = user
  end

  def fetch_accounts
    response = File.read('./spec/fixtures/accounts_response.json')
    # response = connection.get('accounts')
    parse_data(response)
  end

  def fetch_tokens(code)
    response = Faraday.post("https://app.youneedabudget.com/oauth/token?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}&redirect_uri=http://localhost:3000/auth/ynab/callback&grant_type=authorization_code&code=#{code}")
    parse_data(response.body)
  end

private

  def connection
    Faraday.new("https://api.youneedabudget.com/v1/budgets/default") do |faraday|
      faraday.params["access_token"] = @current_user.access_token
      faraday.adapter Faraday.default_adapter
    end
  end

  def parse_data(response)
    JSON.parse(response, symbolize_names: true)
  end
end
