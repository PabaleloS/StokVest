class AddFirstNameToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :first_name, :string
  end
end
