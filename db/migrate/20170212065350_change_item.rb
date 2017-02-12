class ChangeItem < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.references :tone, foreign_key: true
      t.references :texture, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
