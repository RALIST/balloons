class Delivery::MainController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Заказать оформление воздушными шарами недорого с бесплатной доставкой по Ижевску в компании Шариковая Фея',
                  description: "Доставка на дом и оформление воздушными шарами с гелием круглосуточно по недорогой цене в Ижевске в компании Шариковая Фея"
                  keywords: 'воздушные шары, гелиевые шары, гелиевые шарики, заказать воздушные шары, шарики с доставкой, доставка шариков, купить воздушные шары, купить шарики'
    @compositions = Composition.availible.limit(6).offset(rand(Composition.availible.count)).order(:price)
    @composition  = Composition.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    set_meta_tags title: "Заказать воздушные шары на #{params[:tag_name]} в Ижевске в компании Шариковая Фея",
                  description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                  reverse: true,
                  keywords: "воздушные шары на #{params[:tag_name]}, заказать воздушные шары на #{params[:tag_name]}, шарики с доставкой на #{params[:tag_name]}, доставка шариков на #{params[:tag_name]}"
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

  def by_tag
    set_meta_tags title: "Заказать воздушные шары на #{params[:tag_name]} в Ижевске в компании Шариковая Фея",
                  description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                  reverse: true,
                  keywords: "воздушные шары на #{params[:tag_name]}, заказать воздушные шары на #{params[:tag_name]}, шарики с доставкой на #{params[:tag_name]}, доставка шариков на #{params[:tag_name]}"
    unless params[:tag_name].blank?
      tag = params[:tag_name].downcase.strip
      @compositions =  Composition.availible.with_tag(tag).order(:price).paginate(page: params[:page], per_page: 6)
    end
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'По запросу ' + params[:tag_name] + ' ничего не найдено!'} unless @compositions.any?}
      format.js {render 'index'} if params[:page]
    end
  end


  def by_price
      set_meta_tags title: "Воздушные шары на #{params[:tag_name]} с доставкой!",
                    description: "Воздушные шары на #{params[:tag_name]}",
                    reverse: true,
                    keywords: "композиции из воздушных шары от #{params[:min]} до #{params[:max]}, заказать композиции из воздушных шары от #{params[:min]} до #{params[:max]}, шарики с доставкой от #{params[:min]} до #{params[:max]}, доставка шариков композиции из воздушных шары от #{params[:min]} до #{params[:max]}"
    @compositions = Composition.availible.price_range(params[:min], params[:max]).order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'Нет композиций в этом диапазоне!'} unless @compositions.any?}
      format.js {render 'index'} if params[:page]
    end
  end

  def by_person
    set_meta_tags title: "#{params[:title].capitalize}",
                  description: "Воздушные шары #{params[:title]}",
                  reverse: true,
                  keywords: "воздушные шары #{params[:title]}, гелиевые шары #{params[:title]}, гелиевые шарики #{params[:title]}, заказать воздушные шары#{params[:title]}, шарики с доставкой #{params[:title]}, доставка шариков #{params[:title]}, купить воздушные шары #{params[:title]}, купить шарики #{params[:title]}"
    @compositions = Composition.with_receivers(params[:title]).availible.order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html  {redirect_to root_path, flash: {danger: 'Нет композиций!'} unless @compositions.any?}
      format.js {render 'index'} if params[:page]
    end
  end

  def thanks
    @order = Order.find(params[:order])
  end


  def contacts
  end

  def lp
    @disable_header = true
    cookies.permanent[:landing] = true
    @compositions = Composition.availible.offset(rand(Composition.availible.count)).limit(10)
  end

  def prices
  end
end
