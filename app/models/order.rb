class Order < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :items, through: :subspositions
  has_many :products, through: :subpositions
  has_many :positions, dependent: :destroy
  validates :user_id, :order_date, :phone, :address, :name, :total, presence: true
  validate :availible_date

  before_validation :normalize_date
  after_commit :send_sms_to_admin, :send_sms_to_user

  attr_accessor :order_time

  def save_user(params = {})
    user = User.find_by!(phone: phone)
    self.user ||= user
  rescue ActiveRecord::RecordNotFound
    user = User.create(first_name: name,
                        phone: phone,
                        password: Unicode.downcase(name),
                        address: address)
    self.user = user
  end

  def send_admin_notification
    AdminMailer.new_order_notify(self).deliver_now
  end

  private
  def normalize_date
    self.order_date = Time.zone.parse(order_time + ' ' + order_date.to_s)
  end

  def availible_date
    if self.order_date - Time.current < 2.hours
      errors.add(:order_date, 'Возможно, мы не успеем привезти ваш заказ вовремя! Пожалуйста, дайте нам больше времени!')
    end
  end

  def send_sms_to_admin
    new_order = 'Заказ №' + self.id.to_s + ' ' + Russian::strftime(self.order_date.in_time_zone,
                  ' %d.%m в %H:%M').to_s + '. Телефон:' + ' ' + self.user.phone
    message = MainsmsApi::Message.new(sender: 'sendertest', message: new_order,
                                      recipients: ['79124532598'])
    response = message.deliver
  end

  def send_sms_to_user
    order = 'Спасибо за заказ! Мы свяжемся с вами в ближайшее время! Шариковая фея'
    phone = self.phone.tr('()+ ', '')
    message = MainsmsApi::Message.new(message: order,
                                      recipients: [phone])
    response = message.deliver
  end

  def self.pay_methods
    ['Наличными курьеру', 'Сбербанк Онлайн']
  end
end
