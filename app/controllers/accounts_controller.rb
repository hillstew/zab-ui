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
  end

  def create
    params['accounts'].each do |account, details|
      if details.has_key?('checked')
        params = account_params(account, details)
        account = Account.create!(params)
      end
    end
    redirect_to dashboard_path
  end

  private
  def account_params(account, details)
    {
      name: account,
      user_id: current_user.id,
      ynab_id: details['ynab_id'],
      min_payment: details['min_payment'].to_f,
      starting_total: details['starting_total'].to_f.abs / 1000,
      interest_rate: details['interest_rate'].to_f,
      balance: (details['starting_total'].to_f.abs / 1000)
    }
  end


end
