class JoinTableReceiverComposition < ActiveRecord::Migration[5.0]
  def change
    create_table :compositions_receivers, id: false do |t|
      t.integer :composition_id
      t.integer :receiver_id
    end
    add_index :compositions_receivers, [:composition_id, :receiver_id]
  end
end
