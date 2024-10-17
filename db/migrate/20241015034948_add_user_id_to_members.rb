class AddUserIdToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :user_id, :integer
  end
end
