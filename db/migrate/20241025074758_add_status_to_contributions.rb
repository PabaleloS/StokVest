class AddStatusToContributions < ActiveRecord::Migration[7.1]
  def change
    add_column :contributions, :status, :string
  end
end
