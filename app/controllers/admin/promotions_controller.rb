class Admin::PromotionsController < Admin::AdminController
  before_action :set_promo, only: %i[show edit update destroy]

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.create(promo_params)
  end

  def show; end

  def update; end

  def edit; end

  def destroy; end

  def index; end

  private

  def set_promo
    @promotion = Promotion.find(params[:id])
  end

  def promo_params
    params.require(:promotion).permit(:name, :code, :desc, :img, :start_date, :end_date)
  end
end
