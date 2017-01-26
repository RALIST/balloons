class Delivery::OrdersController < Delivery::DeliveryController

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    @order.total = @cart.total_price
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
        p.update_attribute(:cart_id, nil)
      end
      @order.user.calculate_discount
      redirect_to delivery_order_path(@order)
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
    params.require(:order).permit(:name, :phone, :address, :desc, :total, :order_date, :order_time)
  end
end
