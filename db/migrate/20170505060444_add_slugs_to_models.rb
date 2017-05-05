class AddSlugsToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :slug, :string
    add_column :receivers, :slug, :string
    add_index :tags, :slug
    add_index :receivers, :slug
  end
end
