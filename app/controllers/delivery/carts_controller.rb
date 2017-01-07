class Delivery::CartsController < Delivery::DeliveryController
  before_action :current_cart

  def index
  end

  def add_to_cart
    @composition = Composition.find(params[:composition_id])
    if !@cart.compositions.include?(@composition)
      @cart.positions.create(composition: @composition) 
      @composition.items.uniq.each do |item|
        quantity = @composition.items.where(id: item.id).count
        @cart.positions.where(composition: @composition).last.subpositions.create(item: item, quantity: quantity)
      end
    end
    redirect_back(fallback_location: delivery_root_path)
  end
end