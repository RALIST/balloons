class AddAttachmentImgToSubcategories < ActiveRecord::Migration[5.0]
  def self.up
    change_table :subcategories do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :subcategories, :img
  end
end
