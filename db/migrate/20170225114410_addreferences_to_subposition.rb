class AddreferencesToSubposition < ActiveRecord::Migration[5.0]
  def change
    change_table :subpositions do |t|
      t.remove :item_id
      t.references :product, foreign_key: true
    end
  end
end
