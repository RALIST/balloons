class AddSlugToColors < ActiveRecord::Migration[5.0]
  def change
    add_column :colors, :slug, :string
    add_column :subcategories, :slug, :string
  end
end
