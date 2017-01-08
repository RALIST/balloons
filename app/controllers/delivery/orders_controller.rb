class Delivery::OrdersController < Delivery::DeliveryController

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    @cart.positions.each do |p|
      @order.positions.push(p)
    end
    @order.total = @cart.total_price

    if current_user
      @order.user = current_user
    else
      user = User.find_by!(phone: params[:phone])
      @order.user = user
      @user.update(first_name: params[:order][:name],
                          address: params[:order][:address])
    end
    rescue ActiveRecord::RecordNotFound
      @user = User.create(first_name: params[:order][:name],
                          phone: params[:order][:phone],
                          address: params[:order][:address], 
                          password: params[:order][:name])
      auto_login(@user)
      @cart.user = @user
      @order.user = @user

    if @order.save
      @cart.positions.each do |p|
        p.update_attribute(:cart_id, nil)
      end
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