class AddDeletedToCompositions < ActiveRecord::Migration[5.0]
  def change
    add_column :compositions, :deleted, :boolean, default: false
  end
end
