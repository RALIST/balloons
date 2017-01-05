class CreateCompositions < ActiveRecord::Migration[5.0]
  def change
    create_table :compositions do |t|
      t.string :title
      t.string :price
      t.attachment :img
      t.timestamps
    end
  end
end
