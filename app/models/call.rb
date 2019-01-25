class Call < ApplicationRecord
  # after_save :send_new_call_notification, :send_sms_to_admin

  def send_new_call_notification
    AdminMailer.new_call_order_notify(self).deliver_now
  end

  def send_sms_to_admin
    new_call = 'Заявка на обратный звонок: ' + userphone.to_s + ' ' + username + ' ' + (messangers ? messangers.join(',') : '') + ' ' + I18n.t("cities.#{city}.base")
    message = MainsmsApi::Message.new(sender: 'shar_feya', message: new_call,
                                      recipients: ['79501718109'])
    response = message.deliver unless Rails.env.development?
  end
end
