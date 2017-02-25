class Delivery::CartsController < Delivery::DeliveryController

  def index
  end

  def show
    @cart = current_cart
    @collections = Color.all
    @items_in_collection = Product.availible_in_compositions.joins(:color).where(colors: {id: params[:collection_id]})
    @position = Position.find(params[:position]) if params[:position]
    respond_to do |format|
      format.html
      format.js
    end
  end



  def add_to_cart
    @composition = Composition.find(params[:id])
    unless current_cart.compositions.include?(@composition)
      current_cart.positions.create(composition: @composition)
      @composition.products.uniq.each do |product|
        quantity = @composition.products.where(id: product.id).count
        current_cart.positions.where(composition: @composition).last.subpositions.create(product: product, quantity: quantity)
      end
      flash.now[:success] = 'Композиция добавлена в корзину!'
    else
      flash.now[:danger] = 'Эта композиция уже в корзине!'
    end
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end

  end

  def remove_from_cart
    @position = Position.find(params[:id])
    current_cart.positions.destroy(@position)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end
end
