class AddNameToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :name, :string
    remove_column :tones, :code
    add_column :tones, :code, :integer
  end
end
