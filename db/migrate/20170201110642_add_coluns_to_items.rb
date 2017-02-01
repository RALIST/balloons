class AddColunsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :color, :string
    add_column :items, :availible_in_comps, :boolean, default: false
    add_column :items, :size, :string
    add_column :items, :quantity, :float, default: 0.0
  end
end
