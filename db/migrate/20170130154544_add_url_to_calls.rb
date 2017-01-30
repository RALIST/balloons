class AddUrlToCalls < ActiveRecord::Migration[5.0]
  def change
    add_column :calls, :url, :string
  end
end
