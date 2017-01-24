class AdminMailer < ApplicationMailer

  def new_order_notify(order)
    @order = order
    mail(to: 'info@bigairballoons.ru', subject: "Новый заказ №#{@order.id} создан")
  end
end
