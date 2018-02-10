class AdminMailer < ApplicationMailer
  def new_order_notify(order)
    @order = order
    mail(to: 'lelly89@mail.ru', subject: "Новый заказ №#{@order.id} создан")
  end

  def new_call_order_notify(call)
    @call = call
    mail(to: 'lelly89@mail.ru', subject: "\u0417\u0430\u044F\u0432\u043A\u0430 \u043D\u0430 \u043E\u0431\u0440\u0430\u0442\u043D\u044B\u0439 \u0437\u0432\u043E\u043D\u043E\u043A")
  end
end
