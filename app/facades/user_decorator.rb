class UserDecorator < SimpleDelegator
  def initialize(user)
    @user = super(user)
    @service = ZabService.new
  end

  def active_accounts
    accounts_data = @service.fetch_accounts(@user.access_token)
    accounts_data[:data][:accounts].find_all{|account| account[:deleted] == false}
  end

  def updated_accounts
    active_accounts
  end
end
