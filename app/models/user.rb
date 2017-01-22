class User < ApplicationRecord
  authenticates_with_sorcery!

  before_save :set_name
  before_create :normalize_password

  has_one :cart
  has_many :orders, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :phone, uniqueness: true, length: { is: 10 }, numericality: { only_integer: true }



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
      self.first_name = password
    end
  end

  def normalize_password
    self.password = Unicode.downcase(password) unless password.blank?
  end
end
