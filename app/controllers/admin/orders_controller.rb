class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: %i[show destroy]
  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def new
    @order = Order.new
    @user = User.find(params[:user])
  end

  def create

    @order = Order.create(order_params)

    if @order.save
      redirect_to admin_users_path
      flash[:success] = 'Заказ добавлен!'
    else
      flash[:alert] = 'Заказ не удалось сохранить!'
      render :new
    end

  end

  def show; end

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

  def order_params
    params.require(:order).permit(:name, :phone, :address, :desc, :total, :order_date, :order_time, :pay_method, :city, :user_id, :admin)
  end
end
