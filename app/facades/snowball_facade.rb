class SnowballFacade
  def initialize(data)
    @snowball_data = data
    @accounts = current_user.accounts
  end

  def snowball_amount
    total_min_payments = @accounts.sum(&:min_payment)
    @snowball_data - total_min_payments
  end
end
