class AddReferences < ActiveRecord::Migration[5.0]
  def change
    change_table :items_in_compositions do |t|
      t.references :product, foreign_key: true
    end
  end
end
