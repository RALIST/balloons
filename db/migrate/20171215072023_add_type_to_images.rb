class AddTypeToImages < ActiveRecord::Migration[5.0]
  def change
    change_table :images do |t|
      t.string :style
    end
  end
end
