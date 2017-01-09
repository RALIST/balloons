class Delivery::OrdersController < Delivery::DeliveryController

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    @cart.positions.each do |p|
      @order.positions.push(p)
      p.update_attribute(:cart_id, nil)
    end
    @order.total = @cart.total_price
    if current_user
      @order.user = current_user
    else
      @order.save_user(order_params)
      auto_login(@order.user)
    end
    if @order.save
      @cart.destroy
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
    params.require(:order).permit(:name, :phone, :address, :desc, :total)
  end
end