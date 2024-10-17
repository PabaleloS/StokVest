class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :name
      t.decimal :contribution
      t.date :join_date
      t.references :stokvel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
