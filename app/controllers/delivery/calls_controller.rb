class Delivery::CallsController < Delivery::DeliveryController

  skip_before_action :verify_authenticity_token

  def create
    @call = Call.new(call_params)
    if verify_recaptcha(action: 'call', minimum_score: 0.5) && @call.save
      logger.tagged('RECAPTCHA') { logger.info recaptcha_reply }
      redirect_to after_call_path
    else
      flash[:danger] = @call.errors.full_messages.join(', ')
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
