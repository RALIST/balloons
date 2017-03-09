class Delivery::UsersController < Delivery::DeliveryController

  def new
    set_meta_tags title: 'Регистрация',
                  reverse: true,
                  description: 'Зарегистрируйтесь на сайте'
    @user = User.new
    @disable_header = true
  end

  def create
    @user = User.create(user_params)
    if @user.save
      auto_login(@user, should_remember = true)
      @user.cart = @cart
      flash[:success] = 'Вы успешно зарегистрировались!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Не удалось зарегистрироваться. Проверьте данные'
      render 'new'
    end
  end

  def show
    set_meta_tags title: 'Личный кабинет',
                  reverse: true,
                  description: 'Личный кабинет пользователя'
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
