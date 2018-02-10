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

  def fogot_password
    if @user = User.find_by(phone: params[:phone])
      if @user.send_password
        flash[:success] = 'Пароль отправлен вам в смс!'
        redirect_to login_path
      else
        flash[:danger] = 'Не удалось отправить вам пароль!'
        redirect_to login_path
      end
    else
      flash[:danger] = 'Пользователь не найден!'
      redirect_to login_path
    end
  end

  def show
    set_meta_tags title: 'Личный кабинет',
                  reverse: true,
                  description: 'Личный кабинет пользователя'
    @user = current_user
  end

  def edit; end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Успешно изменено!'
      redirect_to cp_path
    else
      flash[:danger] = 'Не удалось изменить'
      redirect_to cp_path
    end
  end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:phone, :password, :first_name)
  end
end
