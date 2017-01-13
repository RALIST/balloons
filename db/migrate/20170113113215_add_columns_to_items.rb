class AddColumnsToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.string :made_by
      t.string :barcode
    end
  end
end
