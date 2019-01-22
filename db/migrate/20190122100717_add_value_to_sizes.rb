class AddValueToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :value, :integer
  end
end
