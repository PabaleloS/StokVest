class ChangeTransactionTypeToIntegerInTransactions < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :transaction_type, :integer
  end
end
