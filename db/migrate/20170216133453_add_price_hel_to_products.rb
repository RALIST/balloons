class AddPriceHelToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price_with_helium, :float
    remove_column :tones, :code
    add_column :tones, :code, :string
  end
end
