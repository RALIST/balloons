class Delivery::CompositionsController < Delivery::DeliveryController
  before_action :set_composition, only: :show
  before_action :set_meta_tags_for_composition

  include CompositionsHelper

  def index
    @compositions = Composition.availible.distinct.order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html
      format.js if params[:page]
    end
  end

  def show
    @products = @comp.products.includes(:type, :size, :tone, :texture).distinct
    @comp.update_attributes(views: @comp.views + 1)
    @tag = Tag.friendly.find(params[:tag_id]) if params[:tag_id]
    @receiver = Receiver.friendly.find(params[:receiver_id]) if params[:receiver_id]
  end

  private

  def set_composition
    @comp = Composition.find(params[:id])
  end

end
