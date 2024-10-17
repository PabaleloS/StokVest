class RemoveGroupIdFromPayouts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :payouts, :group, foreign_key: true
  end
end
