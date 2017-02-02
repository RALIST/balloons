class Delivery::CompositionsController < Delivery::DeliveryController
  def index
    @compositions = Composition.availible
  end

  def show
    @comp = Composition.find(params[:id])
  end

end
