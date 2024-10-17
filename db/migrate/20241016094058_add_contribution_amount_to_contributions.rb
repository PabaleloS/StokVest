class AddContributionAmountToContributions < ActiveRecord::Migration[7.1]
  def change
    add_column :contributions, :contribution_amount, :decimal
  end
end
