class Admin::SubcategoriesController < Admin::AdminController

  def new
    @subcategory = Subcategory.new
  end

  def show
    @items = subcategory.items.paginate(page: params[:page], per_page: 20)
  end


  private

  def subcategory
    @subcategory ||= Subcategory.find(params[:id])
  end
end
