class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: %i[edit update show destroy]

  def new
    @product = Product.new
    @item = @product.build_item
  end

  def create
    @product = Product.create(product_params)
  end

  def update

    redirect_to admin_items_path if @product.update(product_params)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @item = @product.item
  end

  def destroy
    redirect_back fallback_location: admin_root_path if @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :barcode, :code, :size_id, :quantity, :price, :item_id, :img,  :price_with_helium, item_attributes: [:color_id, :category_id, :texture_id, :tone_id, :foil_form_id, :type_id, subcategory_ids: []])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
