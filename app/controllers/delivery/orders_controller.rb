class Delivery::OrdersController < Delivery::DeliveryController

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    @order.total = @cart.total_with_discounts
    if current_user
      @order.user = current_user
    else
      @order.save_user(order_params)
      auto_login(@order.user, should_remember: true)
      @order.user.cart = @cart if @order.user.cart.blank?
    end
    @cart.positions.each do |p|
      @order.positions.push(p)
    end
    if @order.save && @order.user.present?
      @cart.positions.each do |p|
        @cart.positions.delete(p)
      end
      @order.send_admin_notification
      @order.user.calculate_discount
      redirect_to thanks_path(order: @order)
    else
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
  end




  private

  def order_params
    params.require(:order).permit(:name, :phone, :address, :desc, :total, :order_date, :order_time, :pay_method)
  end
end
