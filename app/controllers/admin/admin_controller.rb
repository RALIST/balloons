class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :check_is_admin

  private

  def check_is_admin
    if current_user && current_user.admin?
      true
    else
      redirect_to admin_login_path
    end
  end
end
