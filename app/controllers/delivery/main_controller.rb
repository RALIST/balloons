class Delivery::MainController < Delivery::DeliveryController
  def index
    set_meta_tags title: 'Доставка и оформление воздушными шарами в Ижевске от Шариковой феи',
                  description: 'Оформление торжества воздушными шарами от "Шариковой феи" оставит приятные впечатления и сделает этот день ярким. Для заказа звоните по телефону +7 (912) 453-25-98',
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
    set_meta_tags og: {
      title: 'Доставка и оформление воздушными шарами в Ижевске от Шариковой феи',
      description: 'Оформление торжества воздушными шарами от "Шариковой феи" оставит приятные впечатления и сделает этот день ярким. Для оформления заказа звоните по телефону +7 (912) 453-25-98',
      type: 'article',
      url: request.url,
      image: {
        _: view_context.image_path('logo1.png'),
        width: 1000
      },
      site_name: 'Шариковая фея'
    }

    @compositions = Composition.availible.with_tag('день рождения').order(:price).offset(5).limit(3)
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
    set_meta_tags title: "Оформление воздушными шарами до #{params[:max]} рублей",
                  description: "Воздушные шары на #{params[:tag_name]}",
                  reverse: true
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
    set_meta_tags title: "\u041A\u043E\u043D\u0442\u0430\u043A\u0442\u044B"
  end

  def lp
    set_meta_tags title: 'Заказать оформление воздушными шарами недорого с бесплатной доставкой по Ижевску в компании Шариковая Фея',
                  description: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u043D\u0430 \u0434\u043E\u043C \u0438 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u0441 \u0433\u0435\u043B\u0438\u0435\u043C \u043A\u0440\u0443\u0433\u043B\u043E\u0441\u0443\u0442\u043E\u0447\u043D\u043E \u043F\u043E \u043D\u0435\u0434\u043E\u0440\u043E\u0433\u043E\u0439 \u0446\u0435\u043D\u0435 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435 \u0432 \u043A\u043E\u043C\u043F\u0430\u043D\u0438\u0438 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u0430\u044F \u0424\u0435\u044F"
    @disable_header = true
    cookies.permanent[:landing] = true
    @compositions = Composition.availible.limit(10)
  end

  def prices
    set_meta_tags title: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435",
                  description: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435"
  end

  def about
    set_meta_tags title: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435",
                  description: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435"
  end

  def info
    set_meta_tags title: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435",
                  description: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435"
  end

  def garant
    set_meta_tags title: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435",
                  description: "\u0414\u043E\u0441\u0442\u0430\u0432\u043A\u0430 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0418\u0436\u0435\u0432\u0441\u043A\u0435"
  end
end
