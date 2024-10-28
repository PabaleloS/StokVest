class AddLastPayoutToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :last_payout_date, :datetime
    add_column :members, :last_payout_amount, :decimal
  end
end
