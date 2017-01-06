class AddCompositionToPositions < ActiveRecord::Migration[5.0]
  def change
    change_table :positions do |t|
      t.references :composition
    end
  end
end
