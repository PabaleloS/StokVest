class AddMemberIdToContributions < ActiveRecord::Migration[7.1]
  def change
    add_column :contributions, :member_id, :integer
  end
end
