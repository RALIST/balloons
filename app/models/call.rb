class Call < ApplicationRecord

after_save :send_new_call_notification, :send_sms_to_admin

  private
  def send_new_call_notification
    AdminMailer.new_call_order_notify(self).deliver_now
  end

  def send_sms_to_admin
    new_call = 'Заявка на обратный звонок: ' + self.userphone.to_s + ' ' + self.username + ' ' + (self.messangers ? self.messangers.join(',') : "")
    message = MainsmsApi::Message.new(sender: 'sendertest', message: new_call,
                                      recipients: ['79124532598', '79124614168'])
    response = message.deliver
  end
end
