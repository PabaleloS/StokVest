class AddDateToPayouts < ActiveRecord::Migration[7.1]
  def change
    add_column :payouts, :date, :date
  end
end
