class AddPromocardToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :card, :integer
  end
end
