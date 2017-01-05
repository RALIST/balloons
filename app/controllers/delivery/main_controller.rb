class Delivery::MainController < Delivery::DeliveryController
  def index
    @compositions = Composition.all
  end
end
