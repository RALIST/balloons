class Admin::ColorsController < Admin::AdminController

  def new
    @color = Color.new
  end

  def create
    @color = Color.create(color_params)
    redirect_to admin_items_path
  end

  private
  def color_params
    params.require(:color).permit(:name, :eng_name)
  end
end
