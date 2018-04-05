class Delivery::MainController < Delivery::DeliveryController

  before_action :set_meta_tags_for_main

  def index
    @birthday = Composition.availible.with_tag('день рождения').order(:views).reverse_order
    @roddom = Composition.availible.with_tag('выписку из роддома').order(:views).reverse_order
    @popular= Composition.availible.order(:views).reverse_order
    @composition  = Composition.find(params[:id]) if params[:id]
    @feeds = Feedback.all.last(6)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def by_price
    @compositions = Composition.availible.price_range(params[:min], params[:max]).order(:price)
    respond_to do |format|
      format.html { redirect_to root_path, flash: { danger: 'Нет композиций в этом диапазоне!' } unless @compositions.any? }
      format.js
    end
  end

  def thanks
    @order = Order.find(params[:order])
  end

  def contacts

  end

  def lp
  end

  def prices

  end

  def about

  end

  def info

  end

  def garant

  end
end
