class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  validates :name, :img, :price, presence: true
  has_attached_file :img
  validates_attachment_content_type :img, 
                        content_type: ["image/jpeg", "image/jpg"]
end
