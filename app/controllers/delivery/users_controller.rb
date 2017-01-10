class Delivery::UsersController < Delivery::DeliveryController

  def new
    @user = User.new
    @hide_header = true
    @hide_footer = true
  end

  def create
    @user = User.create(user_params)
    if @user.save
      auto_login(@user)
      redirect_to delivery_root_path
    end
  end

  def show
    @user = current_user
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:phone, :password, :password_confirmation)
  end

end
