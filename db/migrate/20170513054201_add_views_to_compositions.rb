class AddViewsToCompositions < ActiveRecord::Migration[5.0]
  def change
    add_column :compositions, :views, :integer, default: 0
  end
end
