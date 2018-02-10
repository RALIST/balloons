class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :positions, dependent: :destroy
  has_many :subpositions

  def total_price
    total = 0
    positions.each do |p|
      total += p.subpositions.includes(:product).map { |s| s.product.price_with_helium.to_f * s.quantity }.sum
    end
    total
  end

  def total_with_discounts
    if user.blank?
      total = total_price
      total += 200 if total < 1000
    else
      total = total_price - (total_price * user.discount / 100)
      total += 200 if total < 1000
    end
    total -= (total * used_code_discount / 100) if used_code_discount.present?
    self.total = total
    save
  end

  def apply_code
    self.used_code_discount = 5
    save
  end

  def remove_code
    self.used_code_discount = 0
    save
  end
end
