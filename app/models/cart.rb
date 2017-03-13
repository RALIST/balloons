class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :positions
  has_many :subpositions

  def total_price
    total = 0
    self.positions.each do |p|
      total += p.subpositions.includes(:product).map{|s| s.product.price_with_helium.to_f * s.quantity}.sum
    end
    return total.round(2)
  end

  def total_with_discounts
    unless self.user.blank?
      total = self.total_price - (self.total_price * user.discount / 100)
      if total < 1000
        total += 150
      end
    else
      total = self.total_price + 150
      if total < 1000
        total += 150
      end
    end
    return total.round(2)
  end
end
