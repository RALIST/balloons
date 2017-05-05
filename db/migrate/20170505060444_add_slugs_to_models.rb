class AddSlugsToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :slug, :string, unique: true
    add_column :receivers, :slug, :string, unique: true
    add_index :tags, :slug
    add_index :receivers, :slug
  end
end
