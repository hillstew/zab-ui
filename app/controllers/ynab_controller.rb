class YnabController < ApplicationController
  def new
    @client_id = ENV['CLIENT_ID']
  end

  def create
    tokens = YnabService.new.fetch_tokens(params['code'])
    user_data = format_user_data(tokens)
    current_user.update!(user_data)
    redirect_to signup_accounts_path
  end

  private

  def format_user_data(token_data)
    {
      access_token: raw_token_data[:access_token],
      refresh_token: raw_token_data[:refresh_token],
      last_login: DateTime.now
    }
  end
end
