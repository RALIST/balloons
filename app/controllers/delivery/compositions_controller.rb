class Delivery::CompositionsController < Delivery::DeliveryController
  def index
  end

  def show
    @comp = Composition.find(params[:id])
  end

end
