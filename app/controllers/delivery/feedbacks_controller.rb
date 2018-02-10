class Delivery::FeedbacksController < Delivery::DeliveryController
  before_action :set_feedback, only: %i[show edit update destroy]

  def index
    @feedbacks = Feedback.all.paginate(page: params[:page], per_page: 3)
    @feedback = Feedback.new
    @feed = true
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    respond_to do |format|
      if @feedback.save
        @feedback.send_code_to_user
        format.html { redirect_to feedbacks_path, success: 'Спасибо за ваш отзыв!' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_params
    params.require(:feedback).permit(:name, :body, :img, :phone, :social_url, :promocode)
  end
end
