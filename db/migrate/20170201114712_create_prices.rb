class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.attachment :price_sheet

      t.timestamps
    end
  end
end
