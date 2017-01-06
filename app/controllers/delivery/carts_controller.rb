class Delivery::CartsController < Delivery::DeliveryController
  before_action :current_cart

  def index
  end

  def add_to_cart
    @composition = Composition.find(params[:composition_id])
    @cart.positions.create(composition: @composition)
    redirect_back(fallback_location: delivery_root_path)
  end
end