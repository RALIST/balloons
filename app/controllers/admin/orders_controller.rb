class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: [:show, :destroy]
  def index
    @orders = Order.all
  end

  def show
  end

  def destroy
    if @order.destroy
      redirect_to admin_orders_path
      flash[:success] = 'Заказ был удален!'
    end
  end


  private
  def set_order
    @order = Order.find(params[:id])
  end
end
