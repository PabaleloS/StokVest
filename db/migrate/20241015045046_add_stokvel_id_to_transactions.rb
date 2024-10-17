class AddStokvelIdToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :stokvel_id, :integer
  end
end
