class Delivery::SessionsController < Delivery::DeliveryController
def new
    @user = User.new
  end

  def create
    if @user = login(params[:phone], params[:password])
      redirect_back(fallback_location: delivery_root_path)
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to delivery_root_path
  end
end