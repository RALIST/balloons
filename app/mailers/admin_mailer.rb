class AdminMailer < ApplicationMailer
  def new_order_notify(order)
    @order = order
    mail(to: 'info@bigairballoons.ru', subject: "Новый заказ №#{@order.id} создан")
  end

  def new_call_order_notify(call)
    @call = call
    mail(to: 'info@bigairballoons.ru', subject: "Заявка на обратный звонок!")
  end
end
