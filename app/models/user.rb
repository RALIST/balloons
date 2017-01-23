class User < ApplicationRecord
  authenticates_with_sorcery!

  before_validation :normalize_password
  before_save :set_name

  has_one :cart
  has_many :orders, dependent: :destroy

  validates :password, length: { minimum: 1 }, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :phone, uniqueness: true



  def calculate_discount
    orders_total = self.orders.map{ |order| order.total.to_f}
                              .reject{ |t| t < 1000 || t.blank? }.sum
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
      self.first_name = Unicode.capitalize(password)
    end
  end

  def normalize_password
    self.password = Unicode.downcase(password) unless password.blank?
  end
end
