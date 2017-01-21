class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :positions
  has_many :subpositions

  def total_price
    total = 0
    self.positions.each do |p|
      p.subpositions.each do |sub|
        unless sub.item.price?
          total += sub.item.price.to_f * sub.quantity
        end
      end
    end
    return total.round(2)
  end
end
