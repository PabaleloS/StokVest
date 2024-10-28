class ChangeStatusToIntegerInContributions < ActiveRecord::Migration[7.1]
  def change
    change_column :contributions, :status, :integer, default: 0
  end
end
