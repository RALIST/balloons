class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all
  end

  def show; end

  def new

    @user = User.new

  end

  def create

    @user = User.create(user_params)
    if @user.save
      redirect_to admin_users_path
      flash[:success] = 'Клиент успешно создан!'
    else
      flash[:alert] = 'Не удалось создать клиента!'
      render :new
    end

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :phone)
  end
end
