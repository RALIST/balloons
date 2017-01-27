class Call < ApplicationRecord

after_create :send_new_call_notification

  private
  def send_new_call_notification
    AdminMailer.send_new_call_notify(self).deliver_now
  end
end
