class AddBalanceToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :balance, :integer
  end
end
