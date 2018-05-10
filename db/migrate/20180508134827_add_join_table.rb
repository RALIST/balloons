class AddJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :compositions_tags, id: false do |t|
      t.integer :composition_id
      t.integer :tag_id
    end
    add_index :compositions_tags, [:composition_id, :tag_id]
  end
end
