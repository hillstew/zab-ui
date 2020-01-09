class YnabService
  def initialize(user)
    @current_user = user
  end

  def fetch_tokens(code)
    response = Faraday.post("https://app.youneedabudget.com/oauth/token?client_id=#{ENV['CLIENT_ID']}&client_secret=#{ENV['CLIENT_SECRET']}&redirect_uri=#{ENV['REDIRECT_DOMAIN']}/auth/ynab/callback&grant_type=authorization_code&code=#{code}")
    parse_data(response.body)
  end

private

  def parse_data(response)
    JSON.parse(response, symbolize_names: true)
  end
end
