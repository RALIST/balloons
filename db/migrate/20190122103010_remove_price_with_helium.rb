class RemovePriceWithHelium < ActiveRecord::Migration[5.0]
  def change

    remove_column :products, :price_with_helium

  end
end
