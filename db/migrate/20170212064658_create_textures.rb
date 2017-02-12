class CreateTextures < ActiveRecord::Migration[5.0]
  def change
    create_table :textures do |t|
      t.string :name

      t.timestamps
    end
  end
end
