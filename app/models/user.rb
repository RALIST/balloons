class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :cart
  has_many :orders, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :phone, uniqueness: true


  def calculate_discount
    orders_total = self.orders.map{|order| order.total.to_f}.sum
    discount_rate = orders_total * 0.001
    if dicount_rate > 25
      self.update(discount: 25 ) 
    else
      self.update(discount: discount_rate)
    end
  end

end
