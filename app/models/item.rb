class Item < ApplicationRecord
  has_many :items_in_compositions, dependent: :destroy
  has_many :compositions, through: :items_in_compositions
  has_many :tags, as: :taggable
  has_many :carts, through: :positions
  has_many :position, through: :subpositions

  validates :name, :img, :price, presence: true
  has_attached_file :img
  validates_attachment_content_type :img, 
                        content_type: ["image/jpeg", "image/jpg"]
end
