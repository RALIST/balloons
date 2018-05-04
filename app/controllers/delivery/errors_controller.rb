class Delivery::ErrorsController < Delivery::DeliveryController
  layout nil

  def not_found
    @disable_header = true
    @disable_footer = true
    render(status: 404)
  end

  def internal_server_error
    @disable_header = true
    @disable_footer = true
    render(status: 500)
  end
end
