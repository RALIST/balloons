class ChangeIndexInUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :email
    add_index :users, :phone, unique: true
    change_column :users, :email, :string, null: true
    change_column :users, :phone, :string, null: false
  end
end
