class AddImgToProducts < ActiveRecord::Migration[5.0]
  def change
    add_attachment :tones, :img
    add_attachment :products, :img
  end
end
