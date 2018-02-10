class AddAttrToSize < ActiveRecord::Migration[5.0]
  def change
    change_table :sizes do |t|
      t.integer :barcode
      t.string :code
      t.references :vendor
      t.remove :in_inch
      t.remove :in_cm
      t.remove :belbal
      t.float :in_inch
      t.float :in_cm
      t.integer :belbal
    end

    change_table :tones do |t|
      t.references :vendor, foreign_key: true
      t.string :code
    end
    change_table :items do |t|
      t.references :color, foreign_key: true
    end

    rename_table :item_sizes, :products
  end
end
