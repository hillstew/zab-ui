class AccountsController < ApplicationController
  def new
    # service = YnabService.new
    # service.accounts

    conn = Faraday.new("https://api.youneedabudget.com/v1/budgets/default") do |faraday|
      faraday.params["access_token"] = current_user.access_token
      faraday.adapter Faraday.default_adapter
    end

    response = File.read('./spec/fixtures/accounts_response.json')
    raw_accounts_data = JSON.parse(response, symbolize_names: true)
    @accounts = raw_accounts_data[:data][:accounts].find_all{|account| account[:deleted] == false}
    binding.pry
  end
end
