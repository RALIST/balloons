class Delivery::MainController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Заказать оформление воздушными шарами недорого с бесплатной доставкой по Ижевску в компании Шариковая Фея',
                  description: "Доставка на дом и оформление воздушными шарами с гелием круглосуточно по недорогой цене в Ижевске в компании Шариковая Фея"
    @compositions = Composition.availible.order(:views).reverse_order.limit(6).order(:price)
    @composition  = Composition.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    set_meta_tags title: "Заказать воздушные шары на #{params[:tag_name]} в Ижевске в компании Шариковая Фея",
                  description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                  reverse: true
    unless params[:tag_name].blank?
      tag = Unicode::downcase(params[:tag_name]).strip
      @compositions =  Composition.availible.with_tag(tag).order(:price).paginate(page: params[:page], per_page: 6)
      respond_to do |format|
        format.html{redirect_to root_path, flash: {danger: 'По запросу ' + params[:tag_name] + ' ничего не найдено!'} unless @compositions.any?}
        format.js {render 'index'} if params[:page]
      end
    else
      redirect_back fallback_location: root_path, flash: {danger: 'Ничего не найдено!' }
    end
  end



  def by_price
      set_meta_tags title: "Оформление воздушными шарами до #{params[:max]} рублей",
                    description: "Воздушные шары на #{params[:tag_name]}",
                    reverse: true
    @compositions = Composition.availible.price_range(params[:min], params[:max]).order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'Нет композиций в этом диапазоне!'} unless @compositions.any?}
      format.js {render 'index'} if params[:page]
    end
  end

  def thanks
    @order = Order.find(params[:order])
  end


  def contacts
  end

  def lp
    set_meta_tags title: 'Заказать оформление воздушными шарами недорого с бесплатной доставкой по Ижевску в компании Шариковая Фея',
                  description: "Доставка на дом и оформление воздушными шарами с гелием круглосуточно по недорогой цене в Ижевске в компании Шариковая Фея"
    @disable_header = true
    cookies.permanent[:landing] = true
    @compositions = Composition.availible.limit(10)
  end

  def prices
  end
end
