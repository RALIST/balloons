class Composition < ApplicationRecord
  has_many :items_in_compositions,  dependent: :destroy
  has_many :items, through: :items_in_compositions
  validates :title, :img, presence: true
  has_attached_file :img
  validates_attachment_content_type :img, 
                        content_type: ["image/jpeg", "image/jpg"]

  def comp_price
    price = self.items.map{|i| i.price}.sum
    self.update(price: price)
  end
end
