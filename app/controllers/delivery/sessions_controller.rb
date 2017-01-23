class Delivery::SessionsController < Delivery::DeliveryController
  def new
    @user = User.new
  end

  def create
    password = Unicode.downcase(params[:password])
    if @user = login(params[:phone], password)
      session[:user_id] = @user.id
      remember_me!
      @user.cart = @cart
      redirect_to delivery_root_path
    else
      flash.now[:danger] = 'Не удалось войти!'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to delivery_root_path
  end

end
