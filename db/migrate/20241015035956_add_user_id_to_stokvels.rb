class AddUserIdToStokvels < ActiveRecord::Migration[7.1]
  def change
    add_column :stokvels, :user_id, :integer
  end
end
