class ChangeReceivers < ActiveRecord::Migration[5.0]
  def change
    drop_table :receivers

    create_table :receivers do |t|
      t.text :title
      t.references :personable, polymorphic: true, index: true
    end
  end
end
