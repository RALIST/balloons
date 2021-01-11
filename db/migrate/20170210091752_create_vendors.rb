class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.text :description
      t.string :country

      t.timestamps
    end
  end
end
