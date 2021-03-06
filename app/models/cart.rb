class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items, through: :positions
  has_many :positions, dependent: :destroy
  has_many :compositions, through: :positions
  has_many :subpositions, through: :positions
  has_many :products, through: :subpositions

  def total_price
    total = 0
    positions.each do |p|
      total += p.subpositions.includes(:product).map { |s| s.product.price_with_helium.to_f * s.quantity }.sum
    end
    total
  end

  def total_with_discounts
    total = total_price - user_discount
    total += 200 if total_price < 1500
    self.total = total
    self.save
    return total
  end

  def user_discount
    discount = 0
    discount += (total_price * user.discount / 100) if user
    if used_code_discount.present?
      discount += total_price * used_code_discount / 100
    end
    discount.round(2)
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
