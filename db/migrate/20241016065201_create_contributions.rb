class CreateContributions < ActiveRecord::Migration[7.1]
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
