class AddreferenceToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.references :foil_form, foreign_key: true
    end
  end
end
