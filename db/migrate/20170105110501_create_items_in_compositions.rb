class CreateItemsInCompositions < ActiveRecord::Migration[5.0]
  def change
    create_table :items_in_compositions do |t|
      t.references :item, foreign_key: true, index: true
      t.references :composition, foreign_key: true, index: true
      t.integer :items_count
      t.timestamps
    end
  end
end
