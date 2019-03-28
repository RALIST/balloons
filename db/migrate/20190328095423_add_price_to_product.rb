class AddPriceToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price_with_helium, :float, default: 0
    add_column :products, :complex_name, :string
  end
end
