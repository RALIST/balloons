class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :items_subcategories, id: false do |t|
      t.integer :item_id
      t.integer :subcategory_id
    end
    add_index :items_subcategories, %i[item_id subcategory_id]
  end
end
