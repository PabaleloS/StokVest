class AddNextWithdrawalDateToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :next_withdrawal_date, :date
  end
end
