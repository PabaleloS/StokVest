class AddStokvelIdToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :stokvel_id, :integer
  end
end
