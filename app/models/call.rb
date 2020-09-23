class Call < ApplicationRecord

  after_create_commit :send_sms_to_admin, :send_email_to_admin

  def send_email_to_admin
    AdminMailer.new_call_order_notify(self).deliver_later
  end

  def send_sms_to_admin
    if ENV['SEND_SMS_ON_CALL'].present?
      sms = "#{call_type}: #{username} #{userphone} - #{messangers&.join(',')}, #{url}"
      message = MainsmsApi::Message.new(
        sender: 'shar_feya',
        message: sms,
        recipients: ENV['ADMIN_PHONES'].split(','))
      response = message.deliver
      logger.tagged('MAIN SMS') { logger.debug response }
      update(sms_status: response.status, sms_sent_at: Time.now)
    end
  end
end
