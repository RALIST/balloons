class Delivery::OrdersController < Delivery::DeliveryController
  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    @order.total = @cart.total_price
    if @order.save
      redirect_to delivery_order_path(@order)
    else
      render 'new'
    end
  end

  def show
  end

  def index
  end




  private 

  def order_params
    params.require(:order).permit(:name, :phone, :address, :desc, :total)
  end
end