class User < ApplicationRecord
  authenticates_with_sorcery!

  before_save :set_name

  has_one :cart
  has_many :orders, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :phone, uniqueness: true



  def calculate_discount
    orders_total = self.orders.map{|order| order.total.to_f}.sum
    discount_rate = orders_total * 0.001
    unless discount_rate > 25
      self.update(discount: discount_rate)
    else
      self.update(discount: 25)
    end
  end

  private
  def set_name
    if first_name.blank?
      self.first_name = self.password
    end
  end
end
