class Admin::TypesController < Admin::AdminController
  def new
    @type = Type.new
  end

  def create
    @type = Type.create(type_params)
    redirect_to admin_items_path
  end

  private

  def type_params
    params.require(:type).permit(:name)
  end
end
