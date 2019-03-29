class Delivery::CompositionsController < Delivery::DeliveryController
  before_action :set_composition, only: :show
  before_action :set_meta_tags_for_composition

  include CompositionsHelper

  def index
    @compositions = Composition.availible.distinct.order(:price).paginate(page: params[:page], per_page: 6)
    fresh_when @compositions
    respond_to do |format|
      format.html
      format.js if params[:page]
    end
  end

  def show
    @products = @composition.products.includes(:type, :size, :tone, :texture).distinct
    @composition.update_columns(views: @composition.views + 1)
    fresh_when @composition, public: true
  end

  private

  def set_composition
    @composition = Composition.find(params[:id])
  end

end
