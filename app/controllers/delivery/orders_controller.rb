class Delivery::OrdersController < Delivery::DeliveryController

  before_action :positions_in_cart, only: [:new, :create]

  def new
    @order = Order.new
    @disable_header = true
  end

  def create
    @order = Order.create(order_params)
    @order.total = @cart.total
    if current_user
      @order.user = current_user
    else
      @order.save_user(order_params)
      auto_login(@order.user, should_remember: true)
      @order.user.cart = @cart if @order.user.cart.blank?
    end
    if @order.save && @order.user.present?
      @cart.positions.each do |p|
        @order.positions.push(p)
        p.update(cart_id: nil)
      end
      @cart.remove_code
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
    def positions_in_cart
      unless current_cart.positions.any?
        redirect_to root_path
        flash[:alert] = 'Ваша корзина пуста'
      end
    end

  def order_params
    params.require(:order).permit(:name, :phone, :address, :desc, :total, :order_date, :order_time, :pay_method)
  end
end
