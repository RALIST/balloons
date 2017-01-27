class Call < ApplicationRecord

after_commit :send_new_call_notification

  private
  def send_new_call_notification
    AdminMailer.new_call_order_notify(self).deliver_now
  end
end
