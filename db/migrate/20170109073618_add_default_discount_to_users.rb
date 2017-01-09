class AddDefaultDiscountToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :discount, 0
  end
end
