class CreateTones < ActiveRecord::Migration[5.0]
  def change
    create_table :tones do |t|
      t.string :name
      t.string :eng_name
      t.references :color, foreign_key: true

      t.timestamps
    end
  end
end
