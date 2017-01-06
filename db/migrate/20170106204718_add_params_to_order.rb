class AddParamsToOrder < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.float :total
      t.text :desc
    end
  end
end
