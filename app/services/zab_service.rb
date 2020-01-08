class ZabService
  def fetch_accounts(token)
    response = Faraday.get("https://zab-service.herokuapp.com/api/v1/accounts/#{token}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
