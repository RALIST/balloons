class Delivery::MainController < Delivery::DeliveryController

  before_action :set_meta_tags_for_main
  before_action :disable_sidebar

  def index
    @disable_bread = true
    respond_to do |format|
      format.html
      format.js
    end
  end

  def by_price
    if params[:min].to_i > 0 || params[:max].to_i > 0
      @compositions = Composition.availible.price_range(params[:min], params[:max]).order(:price)
      unless @compositions.any?
        redirect_to root_path
        flash[:danger] = 'Нет композиций в этом диапазоне!'
      end
    else
      redirect_to root_path
      flash[:danger] = 'Необходимо указать хотя бы одну цену!'
    end
  end

  def thanks
    @order = Order.find(params[:order])
  end

  def privacy; end

  def contacts; end

  def lp; end

  def prices; end

  def about; end

  def info; end

  def garant; end

  def faq; end

  def chat_me
    #render layout: false
    http_cache_forever(public: true) {render layout: false}
  end
  
  
end
