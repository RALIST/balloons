class AddTypeToCalls < ActiveRecord::Migration[5.0]
  def change
    add_column :calls, :call_type, :string
  end
end
