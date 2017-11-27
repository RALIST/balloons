class Delivery::MainController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Доставка и оформление воздушными шарами от Шариковой феи в Ижевске',
                  description: 'Оформление торжества воздушными шарами от "Шариковой феи" оставит приятные впечатления и сделает этот день ярким. Для оформления заказа звоните по телефону +7 (912) 453-25-98',
                  keywords: 'доставка воздушных шаров ижевск,
                              воздушные шары с доставкой,
                              воздушные гелиевые шары с доставкой,
                              доставка воздушных шаров цена,
                              оформление воздушными шарами,
                              оформление праздников воздушными шарами,
                              оформление шарами,
                              оформление шарами ижевск,
                              оформление праздников шарами,
                              воздушные шары ижевск,
                              купить воздушные шары ижевск,
                              доставка воздушных шаров ижевск,
                              заказ шаров ижевск,
                              шары на заказ ижевск,
                              заказать шары ижевск,
                              гелиевые шары ижевск,
                              гелиевые шары ижевск недорого,
                              гелиевые шары ижевск купить,
                              гелиевые шары ижевск с доставкой,
                              украшение шарами ижевск,
                              шары ижевск,
                              купить шары ижевск,
                              воздушные шары ижевск,
                              доставка шаров ижевск,
                              шары гелий ижевск,
                              шары в ижевске где купить,
                              заказать гелевые шары в ижевске'
    @compositions =  Composition.availible.with_tag('день рождения').order(:price).offset(5).limit(3)
    @composition  = Composition.find(params[:id]) if params[:id]
    @feeds = Feedback.all
    respond_to do |format|
      format.html
      format.js
    end
    @offer = true
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
    @compositions = Composition.availible.price_range(params[:min], params[:max]).order(:price)
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'Нет композиций в этом диапазоне!'} unless @compositions.any?}
      format.js
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
    set_meta_tags title: "Доставка воздушных шаров в Ижевске",
                  description: "Доставка воздушных шаров в Ижевске"
  end

  def about
    set_meta_tags title: "Доставка воздушных шаров в Ижевске",
                  description: "Доставка воздушных шаров в Ижевске"
  end

  def info
    set_meta_tags title: "Доставка воздушных шаров в Ижевске",
                  description: "Доставка воздушных шаров в Ижевске"
  end

  def garant
    set_meta_tags title: "Доставка воздушных шаров в Ижевске",
                  description: "Доставка воздушных шаров в Ижевске"
  end

end
