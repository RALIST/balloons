class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :positions
  has_many :subpositions

  def total_price
    total = 0
    self.positions.each do |p|
      total += p.subpositions.map{|s| s.item.price_with_helium.to_f * s.quantity}.sum
    end
    return total
  end

  def total_with_discounts
    total = self.total_price - (self.total_price * user.discount / 100 if user.present?)
    return total
  end
end
