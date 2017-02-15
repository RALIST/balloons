class AddBarcodeToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :barcode, :integer
    add_column :products, :code, :string
    remove_column :sizes, :barcode
    remove_column :sizes, :code
  end
end
