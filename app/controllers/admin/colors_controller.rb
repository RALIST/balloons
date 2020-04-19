class Admin::ColorsController < Admin::AdminController
  def new
    @color = Color.new
  end

  def show
    @items = color.items.paginate(page: params[:page], per_page: 20)
  end

  def create
    @color = Color.create(color_params)
    redirect_to admin_items_path
  end

  private

  def color
    @color ||= Color.find(params[:id])
  end

  def color_params
    params.require(:color).permit(:name, :eng_name)
  end
end
