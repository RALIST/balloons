class CreateSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sizes do |t|
      t.string :in_cm
      t.string :in_inch
      t.string :belbal

      t.timestamps
    end
  end
end
