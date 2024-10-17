class RemoveGroupIdFromContributions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :contributions, :group, foreign_key: true
  end
end
