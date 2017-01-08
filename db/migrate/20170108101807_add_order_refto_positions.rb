class AddOrderReftoPositions < ActiveRecord::Migration[5.0]
  def change
    change_table :positions do |t|
      t.references :order, foreign_key: true
    end
  end
end
