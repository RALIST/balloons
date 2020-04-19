class Admin::TypesController < Admin::AdminController
  def new
    @type = Type.new
  end

  def show
    @items = type.items.paginate(page: params[:page], per_page: 20)
  end

  def create
    @type = Type.create(type_params)
    redirect_to admin_items_path
  end

  private

    def type
      @type ||= Type.find(params[:id])
    end

  def type_params
    params.require(:type).permit(:name)
  end
end
