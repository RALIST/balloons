class Delivery::MainController < Delivery::DeliveryController

  before_action :set_meta_tags_for_main
  before_action :disable_sidebar

  def index
    @disable_bread = true
    categories = Subcategory.joins(:products).all
    @categories = categories.distinct(:name).group('subcategories.id').select("subcategories.slug, subcategories.name, subcategories.id, subcategories.updated_at, COUNT(products.id) as total").order('total desc').limit(9)
    respond_to do |format|
      format.html
      format.js
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
    http_cache_forever(public: true) { render layout: false }
  end


end
