class Call < ApplicationRecord
  # after_save :send_new_call_notification, :send_sms_to_admin

  def send_new_call_notification
    AdminMailer.new_call_order_notify(self).deliver_now
  end

  def send_sms_to_admin
    if call_type == 'Запрос цены'
      call_url = Rails.application.routes.url_helpers.admin_call_url(self, host: 'bigairballoons.ru', protocol: 'https')
      new_call = "Запрос цены: #{call_url}"
      message = MainsmsApi::Message.new(sender: 'shar_feya', message: new_call,
                                        recipients: ['79501718109'])
      response = message.deliver unless Rails.env.development?
    else
      new_call = 'Заявка на обратный звонок: ' + userphone.to_s + ' ' + username + ' ' + (messangers ? messangers.join(',') : '') + ' ' + I18n.t("cities.#{city}.base")
      message = MainsmsApi::Message.new(sender: 'shar_feya', message: new_call,
                                        recipients: ['79501718109'])
      response = message.deliver unless Rails.env.development?
    end

  end
end
