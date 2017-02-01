class AddPersonToCompositions < ActiveRecord::Migration[5.0]
  def change
    create_table :receivers, id: false do |t|
      t.text :title
      t.references :personable, polymorphic: true, index: true
    end
  end
end
