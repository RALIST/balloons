class Delivery::CallsController < Delivery::DeliveryController
  def create
    @call = Call.create(call_params)
    if @call.save
      @call.send_sms_to_admin
      @call.send_new_call_notification
      redirect_to root_path
      flash[:success] = 'Спасибо за заявку! Мы свяжемся с вами в ближайшее время!'
    end
  end

  private

  def call_params
    params.require(:call).permit(:username, :userphone, :url, messangers: [])
  end
end
