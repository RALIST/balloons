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
        unless sub.item.price.blank?
          total += sub.item.price.to_f * sub.quantity
        end
      end
    end
    if self.user.present?
      total = total * self.user.discount
    end
    return total.round(2)
  end
end
