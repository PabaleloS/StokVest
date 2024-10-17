class CreateStokvels < ActiveRecord::Migration[7.1]
  def change
    create_table :stokvels do |t|
      t.string :name
      t.text :description
      t.decimal :contribution_amount
      t.integer :contribution_frequency

      t.timestamps
    end
  end
end
