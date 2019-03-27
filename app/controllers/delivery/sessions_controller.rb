class Delivery::SessionsController < Delivery::DeliveryController
  before_action :disable_sidebar
  def new
    set_meta_tags title: 'Войти',
                  reverse: true,
                  description: 'Авторизируйтесь на сайте'
    @user = User.new
  end

  def create
    password = Unicode.downcase(params[:password])
    if @user = login(params[:phone], password)
      cookies.permanent[:user_id] = @user.id
      remember_me!
      @user.cart = @cart
      redirect_to root_path
    else
      flash.now[:danger] = 'Не удалось войти!'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
