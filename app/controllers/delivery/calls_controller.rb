class Delivery::CallsController < Delivery::DeliveryController
  
  skip_before_action :verify_authenticity_token
  
  def create
    @call = Call.create(call_params)
    response =  MyGoogleRecaptcha.human?(
        params['g-recaptcha-response'],
        'call',
        MyGoogleRecaptcha.minimum_score,
        @call)
    Rails.logger.debug response.inspect
    if response && @call.save
      @call.send_sms_to_admin
      @call.send_new_call_notification
      redirect_to after_call_path
    else
      flash[:danger] = @call.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end
  
  def thanks
    @disable_sidebar = true
    @disable_help = true
  
  end

  private

  def call_params
    params.require(:call).permit(:username, :userphone, :url, :city, :event, :person, :budget, :desc, :call_type,  messangers: [])
  end
end
