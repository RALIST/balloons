# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  def new_order_notify
    @order = Order.last
    AdminMailer.new_order_notify(@order)
  end

end
