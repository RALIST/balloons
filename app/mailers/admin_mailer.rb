class AdminMailer < ApplicationMailer
  default from: ENV['MAILGUN_SENDER_EMAIL']

  def new_order_notify(order)
    @order = order
    emails = ENV['ADMIN_EMAILS']
    mail(to: emails, subject: "Новый заказ №#{@order.id} создан")
  end

  def new_call_order_notify(call)
    @call = call
    emails = ENV['ADMIN_EMAILS']
    mail(to: emails, subject: "Заявка")
  end
end
