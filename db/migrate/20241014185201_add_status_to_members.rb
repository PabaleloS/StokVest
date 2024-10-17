class AddStatusToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :status, :integer
  end
end
