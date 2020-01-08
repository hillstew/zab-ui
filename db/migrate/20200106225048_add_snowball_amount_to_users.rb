class AddSnowballAmountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :snowball_amount, :integer, default: 0
  end
end
