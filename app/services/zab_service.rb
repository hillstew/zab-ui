class ZabService
  def fetch_accounts(token)
    response = Faraday.get("#{ENV['ZAB_SERVICE_DOMAIN']}.com/api/v1/accounts/#{token}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
