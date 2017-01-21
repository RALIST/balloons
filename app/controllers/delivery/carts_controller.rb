class Delivery::CartsController < Delivery::DeliveryController
  before_action :current_cart, only: [:add_to_cart]

  def index
  end

  def show
    @cart = current_cart
    @collections = Item.all.map{|i| i.collection}.uniq.reject(&:blank?)
    @items_in_collection = Item.all.where(collection: params[:collection])
    respond_to do |format|
      format.html
      format.js
    end
  end


  def add_to_cart
    @composition = Composition.find(params[:composition_id])
    if !@cart.compositions.include?(@composition)
      @cart.positions.create(composition: @composition)
      @composition.items.uniq.each do |item|
        quantity = @composition.items.where(id: item.id).count
        @cart.positions.where(composition: @composition).last.subpositions.create(item: item, quantity: quantity)
      end
      flash[:success] = 'Композиция добавлена в корзину!'
    else
      flash[:danger] = 'Эта композиция уже в корзине!'
    end
    respond_to do |format|
      format.html {redirect_back(fallback_location: delivery_root_path)}
      format.js
    end

  end

  def remove_from_cart
    @composition = Composition.find(params[:id])
    @position = Position.where(cart: current_cart, composition: @composition).first
    @cart.positions.destroy(@position)
    respond_to do |format|
      format.html {redirect_back(fallback_location: delivery_root_path)}
      format.js
    end
  end
end
