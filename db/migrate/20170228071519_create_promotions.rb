class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :code
      t.datetime :start_date
      t.datetime :end_date
      t.string :desc
      t.timestamps
    end
  end
end
