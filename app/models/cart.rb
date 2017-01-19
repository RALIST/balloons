class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :positions
  has_many :subpositions

  def total_price
    total = 0
    self.positions.each do |p|
      total += p.subpositions.map{|s| s.item.price.to_f * s.quantity}.sum
    end
    return total.round(2)
  end
end
