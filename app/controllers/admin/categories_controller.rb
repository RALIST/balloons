class Admin::CategoriesController < Admin::AdminController

  def new
    @category = Category.new
  end
  def create
    @category = Category.create(category_params)
    redirect_to admin_items_path
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end
end
