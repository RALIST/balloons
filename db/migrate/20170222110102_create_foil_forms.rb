class CreateFoilForms < ActiveRecord::Migration[5.0]
  def change
    create_table :foil_forms do |t|
      t.string :name

      t.timestamps
    end
  end
end
