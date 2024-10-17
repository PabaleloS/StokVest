class AddBalanceToStokvels < ActiveRecord::Migration[7.1]
  def change
    add_column :stokvels, :balance, :decimal
  end
end
