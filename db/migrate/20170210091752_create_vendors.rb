class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.text :description
      t.string :country
      t.attachment :logo

      t.timestamps
    end
  end
end
