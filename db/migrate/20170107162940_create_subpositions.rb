class CreateSubpositions < ActiveRecord::Migration[5.0]
  def change
    create_table :subpositions do |t|
      t.references :position, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
