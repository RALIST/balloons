class Composition < ApplicationRecord
  has_many :items_in_compositions,  dependent: :destroy
  has_many :items, through: :items_in_compositions
  has_many :tags, as: :taggable
  has_many :carts, through: :positions
  validates :title, :img, presence: true
  has_attached_file :img
  validates_attachment_content_type :img, 
                        content_type: ["image/jpeg", "image/jpg", "image/png"]

  def comp_price
    price = self.items.map{|i| i.price}.sum
    self.update(price: price)
  end
end
