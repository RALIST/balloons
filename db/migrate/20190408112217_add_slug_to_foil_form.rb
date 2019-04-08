class AddSlugToFoilForm < ActiveRecord::Migration[5.0]
  def change
    add_column :foil_forms, :slug, :string
  end
end
