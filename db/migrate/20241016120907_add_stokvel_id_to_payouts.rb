class AddStokvelIdToPayouts < ActiveRecord::Migration[7.1]
  def change
    add_reference :payouts, :stokvel, foreign_key: true
  end
end
