class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name
      t.string :eng_name

      t.timestamps
    end

    change_table :items do |f|
      f.references :type, foreign_key: true
    end
  end
end
