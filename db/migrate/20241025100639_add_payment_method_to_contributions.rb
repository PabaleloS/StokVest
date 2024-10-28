class AddPaymentMethodToContributions < ActiveRecord::Migration[7.1]
  def change
    add_column :contributions, :payment_method, :string
  end
end
