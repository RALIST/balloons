class Admin::ProductsController < Admin::AdminController

  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
  end

  def update
    if @product.update(product_params)
      redirect_to admin_root_path
    end
  end


  def show

  end

  def edit

  end

  def destroy
    if @product.destroy
      redirect_back fallback_location: admin_root_path
    end
  end

  private
   def product_params
    params.require(:product).permit(:name, :barcode, :code, :size_id, :quantity, :price, :price_with_helium, :item_id, :img)
   end

   def set_product
    @product = Product.find(params[:id])
   end

end
