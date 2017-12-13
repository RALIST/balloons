class AddTotalToCarts < ActiveRecord::Migration[5.0]
  def change
    change_table :carts do |t|
      t.float :total
    end
  end
end
