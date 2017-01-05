class AddImageToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.attachment :img
    end
  end
end
