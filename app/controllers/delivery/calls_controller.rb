class Delivery::CallsController < Delivery::DeliveryController
  
  skip_before_action :verify_authenticity_token
  
  def create
    @call = Call.create(call_params)
    if NewGoogleRecaptcha.human?(
        params[:new_google_recaptcha_token],
        "call",
        NewGoogleRecaptcha.minimum_score,
        @call) && @call.save
      @call.send_sms_to_admin
      @call.send_new_call_notification
      redirect_to after_call_path
    end
  end
  
  def thanks
    @disable_sidebar = true
    @disable_help = true
  
  end

  private

  def call_params
    params.require(:call).permit(:username, :userphone, :url, :city, :event, :person, :budget, :desc, :new_google_recaptcha_token, messangers: [])
  end
end
