class AddColumnsToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.string :made_by
      t.string :barcode
      t.string :collection
      t.rename :type, :item_type
      t.integer :min_order
      t.string :quantity_type
    end
  end
end
