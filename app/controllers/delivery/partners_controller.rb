class Delivery::PartnersController < Delivery::DeliveryController
  def index
    @disable_header = true
  end
end
