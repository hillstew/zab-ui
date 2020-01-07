class AddCountToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :count, :integer, default: 0
  end
end
