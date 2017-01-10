class Delivery::SessionsController < Delivery::DeliveryController
  before_action :hide
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:phone], params[:password])
      session[:user_id] = @user.id
      redirect_back(fallback_location: delivery_root_path)
    else
      flash.now[:alert] = 'Login failed'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to delivery_root_path
  end

  private

  def hide
    @hide_header = true
    @hide_footer = true
  end
end
