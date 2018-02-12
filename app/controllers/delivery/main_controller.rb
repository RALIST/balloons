class Delivery::MainController < Delivery::DeliveryController

  before_action :set_meta_tags_for_main

  def index
    @compositions = Composition.availible.with_tag('день рождения').order(:price).offset(5).limit(3)
    @composition  = Composition.find(params[:id]) if params[:id]
    @feeds = Feedback.all
    respond_to do |format|
      format.html
      format.js
    end
    @offer = true
    @location = request.location.country.city
  end

  def search
    set_meta_tags title: "Заказать воздушные шары на #{params[:tag_name]} в Ижевске в компании Шариковая Фея",
                  description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                  reverse: true
    if params[:tag_name].blank?
      redirect_back fallback_location: root_path, flash: { danger: 'Ничего не найдено!' }
    else
      tag = Unicode.downcase(params[:tag_name]).strip
      @compositions = Composition.availible.with_tag(tag).order(:price).paginate(page: params[:page], per_page: 6)
      respond_to do |format|
        format.html { redirect_to root_path, flash: { danger: 'По запросу ' + params[:tag_name] + ' ничего не найдено!' } unless @compositions.any? }
        format.js { render 'index' } if params[:page]
      end
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
