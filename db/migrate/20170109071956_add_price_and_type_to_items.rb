class AddPriceAndTypeToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :price_with_helium, :integer
    add_column :items, :type, :string
  end
end
