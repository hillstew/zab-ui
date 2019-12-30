class UserDecorator < SimpleDelegator
  def initialize(user)
    @user = super(user)
    @service = YnabService.new
  end

  def active_accounts
    raw_accounts_data = @service.fetch_accounts
    raw_accounts_data[:data][:accounts].find_all{|account| account[:deleted] == false}
  end
end
