class User < ApplicationRecord
  authenticates_with_sorcery!

  before_validation :normalize_password
  before_save :set_name

  has_one :cart
  has_many :orders, dependent: :destroy

  validates :password, length: { minimum: 1 }, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :phone, uniqueness: true

  CITIES = ['izhevsk', 'sarapul', 'glazov', 'mozhga', 'votkinsk']

  def calculate_discount
    orders_total = orders.map { |order| order.total.to_f }
                         .reject { |t| t < 1000 || t.blank? }.sum
    discount_rate = orders_total * 0.001
    if discount_rate > 25
      update(discount: 25)
    else
      update(discount: discount_rate)
    end
  end

  def send_password
    password = rand(10_000..100_000)
    new_password = 'Ваш новый пароль на сайте Шариковой феи:' + password.to_s
    update_attributes(password: password)
    phone = self.phone.tr('()+ ', '')
    message = MainsmsApi::Message.new(sender: 'sendertest', message: new_password,
                                      recipients: [phone])
    response = message.deliver
    response.status == 'success'
  end

  private

  def set_name
    self.first_name = Unicode.capitalize(password) if first_name.blank?
  end

  def normalize_password
    password = password.to_s
    self.password = Unicode.downcase(password) if password.present?
  end
end
