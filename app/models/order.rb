class Order < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :items, through: :subspositions
  has_many :products, through: :subpositions
  has_many :positions, dependent: :destroy
  validates :user_id, :order_date, :phone, :name, :total, presence: true
  validate :availible_date

  before_validation :normalize_date
  after_save :send_sms_to_admin, :send_sms_to_user, :recalculate_discount

  attr_accessor :order_time, :admin


  def recalculate_discount
    user.calculate_discount
  end

  def save_user(_params = {})
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
    if admin
      time = "#{order_time[4]}:#{order_time[5]}" + ' ' + order_date.to_s
      puts time
      self.order_date = Time.zone.parse(time)
    else
      self.order_date = Time.zone.parse(order_time + ' ' + order_date.to_s)
    end

  end

  def availible_date
    unless admin
      if order_date - Time.current < 2.hours
        errors.add(:order_date, 'Возможно, мы не успеем привезти ваш заказ вовремя! Пожалуйста, дайте нам больше времени!')
      end
    end
  end

  def send_sms_to_admin
    unless admin
      new_order = 'Заказ №' + id.to_s + ' ' + Russian.strftime(order_date.in_time_zone,
                                                               ' %d.%m в %H:%M').to_s + '. Телефон:' + ' ' + self.user.phone
      message = MainsmsApi::Message.new(message: new_order,
                                        recipients: ['79501718109'])
      response = message.deliver
    end
  end

  def send_sms_to_user
    unless admin
      order = 'Спасибо за заказ! Мы свяжемся с вами в ближайшее время! Шариковая фея'
      phone = self.phone.tr('()+ ', '')
      message = MainsmsApi::Message.new(message: order,
                                        recipients: [phone])
      response = message.deliver
    end
  end

  def self.pay_methods
    ['Наличными курьеру', 'Сбербанк Онлайн']
  end
end
