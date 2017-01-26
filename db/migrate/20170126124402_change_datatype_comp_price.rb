class ChangeDatatypeCompPrice < ActiveRecord::Migration[5.0]
  def change
    change_table :compositions do |t|
      t.remove :price
      t.float :price,  default: 0
    end
  end
end
