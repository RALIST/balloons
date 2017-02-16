class ChangeIntegerLimitInProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :barcode, :integer, limit: 8
  end
end
