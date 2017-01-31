class Admin::SessionsController < Admin::AdminController
  skip_before_action :check_is_admin
  layout false

  def new
    @user = User.new
  end

  def create
    @user = User.find_by!(email: params[:email])
    if @user.admin?
      if @user = login(params[:email], params[:password])
        session[:user_id] = @user.id
        remember_me!
        redirect_to admin_root_path
      end
    else
      flash[:danger] = 'Не удалось войти!'
      render 'new'
    end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Вход только для администратора!'
      render 'new'
  end
end
