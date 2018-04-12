class AddCityToCalls < ActiveRecord::Migration[5.0]
  def change
    add_column :calls, :city, :string
  end
end
