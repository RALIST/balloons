class RemoveColumnsFromItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.remove :price
      remove_attachment :items, :img
      t.remove :price_with_helium
      t.remove :made_by
      t.remove :barcode
      t.remove :code
      t.remove :collection
      t.remove :min_order
      t.remove :quantity_type
      t.remove :color
      t.remove :availible_in_comps
      t.remove :size
      t.remove :quantity
    end
  end
end
