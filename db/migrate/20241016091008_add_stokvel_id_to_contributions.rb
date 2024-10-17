class AddStokvelIdToContributions < ActiveRecord::Migration[7.1]
  def change
    add_column :contributions, :stokvel_id, :integer
  end
end
