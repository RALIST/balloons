class Delivery::CartsController < Delivery::DeliveryController
  
  before_action :disable_sidebar
  
  def index; end

  def show
    @cart = current_cart
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_to_cart
    @composition = Composition.find(params[:id])
    if current_cart.compositions.include?(@composition)
      flash.now[:danger] = 'Эта композиция уже в корзине!'
    else
      @position = current_cart.positions.create(composition: @composition)
      @composition.products.uniq.each do |product|
        quantity = @composition.products.where(id: product.id).count
        @position.subpositions.create(product: product, quantity: quantity)
      end
      flash.now[:success] = 'Композиция добавлена в корзину!'
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def add_product_to_cart
    @product = Product.find(params[:id])
    @product.touch
    unless current_cart.positions.any?
      @composition = Composition.create
      @composition.products.push(@product)
      current_cart.positions.create(composition: @composition)
      @composition.products.uniq.each do |product|
        quantity = @composition.products.where(id: product.id).count
        current_cart.positions.where(composition: @composition).last.subpositions.create(product: product, quantity: quantity)
      end
    else
      @composition = Composition.find(current_cart.positions.first.composition_id)
      @position = current_cart.positions.first
      if @position.sub_exists?(@product)
        @position.add_quantity_to_sub(@product, 1)
      else
        @position.subpositions.create(product: @product, quantity: 1)
      end
    end
    respond_to do |format|
      format.html
      format.js
    end

  end

  def remove_from_cart
    @position = Position.find(params[:id])
    current_cart.positions.destroy(@position)
    current_cart.remove_code
    current_cart.total_with_discounts
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def apply_code
    code = Feedback.find_by(promocode: params[:code])
    if code
      current_cart.apply_code
      redirect_to my_cart_path
    else
      redirect_back(fallback_location: root_path)
      flash[:danger] = 'Такого промокода не существует'
    end
  end
end
