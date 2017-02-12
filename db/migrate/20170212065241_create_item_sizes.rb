class CreateItemSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :item_sizes do |t|
      t.references :item, foreign_key: true
      t.references :size, foreign_key: true
      t.integer :quantity
      t.float :price
      t.integer :in_box
      t.integer :min_order

      t.timestamps
    end
  end
end
