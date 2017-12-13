class AddCodeToCarts < ActiveRecord::Migration[5.0]
  def change
    change_table :carts do |t|
      t.integer :used_code_discount, default: 0
    end
  end
end
