class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.date :date
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
