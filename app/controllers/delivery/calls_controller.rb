class Delivery::CallsController < Delivery::DeliveryController

  def create
    @call = Call.create(call_params)
  end

  private
  def call_params
    params.require(:call).permit(:username, :userphone, messangers: [], :url)
  end

end
