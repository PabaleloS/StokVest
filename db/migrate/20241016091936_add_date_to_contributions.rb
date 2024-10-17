class AddDateToContributions < ActiveRecord::Migration[7.1]
  def change
    add_column :contributions, :date, :date
  end
end
