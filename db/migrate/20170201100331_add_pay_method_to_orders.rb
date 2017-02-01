class AddPayMethodToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :pay_method, :string
  end
end
