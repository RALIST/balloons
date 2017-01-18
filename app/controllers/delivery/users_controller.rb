class Delivery::UsersController < Delivery::DeliveryController

  def new
    @user = User.new
    @hide_header = true
    @hide_footer = true
  end

  def create
    @user = User.create(user_params)
    if @user.save
      auto_login(@user, should_remember = true)
      @user.cart = @cart
      flash[:success] = 'Вы успешно зарегистрировались!'
      redirect_to delivery_root_path
    else
      flash.now[:danger] = 'Не удалось зарегистрироваться. Проверьте данные'
      render 'new'
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
    params.require(:user).permit(:phone, :password, :first_name)
  end

end
