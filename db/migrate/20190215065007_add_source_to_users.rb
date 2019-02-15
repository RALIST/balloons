class AddSourceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :source, :string
  end
end
