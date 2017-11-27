class Delivery::ReceiversController < Delivery::DeliveryController

  def show
    begin
      @person = Receiver.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      if params[:id].to_i == 0 || params[:id] == '8 марта' || params[:id] == '14 февраля'
        @person = Receiver.find_by!(title: params[:id])
        redirect_to receiver_path(@person), status: 301
      else
        @person = Receiver.find(params[:id])
        redirect_to receiver_path(@person), status: 301
      end
    end

    case @person.title
    when 'для него'
      set_meta_tags title: "Воздушные шары для мужчины с поводом и без",
                  description: "Мужчины тоже любят внимание, а один из главных компонентов настроения - это воздушные шары от Шариковой феи! ",
                  keywords: 'шары для мужчины, воздушные шары для мужчины',
                  reverse: true
    when 'для неё'
      set_meta_tags title: "Воздушные шары для девушки с поводом и без",
                  description: "Девушки не могут жить без внимания, а помочь в этом поможет заказ воздушных шаров в Шариковой фее",
                  keywords: 'шары для девушки, шарики для девушки',
                  reverse: true
    when 'дочке'
      set_meta_tags title: "Шары для любимой дочки от Шариковой феи",
                  description: "Любимая дочь заслуживает всего самого лучшего, а самое лучшее - это подарить человеку настроение! Заказ шаров в Шариковой фее выручит вас.",
                  keywords: 'шары для дочки, шарики для дочки',
                  reverse: true
    when "жене"
      set_meta_tags title: "Шары для дорогой жены от Шариковой феи",
                  description: "Подарить эмоции в нужный момент и создать человеку настроение очень важно. Закажи воздушные шары и поделись счастьем с супругой!",
                  keywords: 'шары для жены',
                  reverse: true
    when "мужчине"
      set_meta_tags title: "Шары для дорогого мужа от Шариковой феи",
                  description: "Подарить эмоции в нужный момент и создать человеку настроение поможет Шариковая фея. Поделись счастьем с супругом!",
                  keywords: 'шары для мужа, шары мужу на день рождения',
                  reverse: true
    when "подруге"
      set_meta_tags title: "Шары для лучшей подруги от Шариковой феи",
                  description: "Появился повод порадовать подругу, но не знаешь как? Закажи шары в Шариковой фее или сделай приятный сюрприз из воздушных шаров для неё.",
                  keywords: 'шары для подруги',
                  reverse: true
    when "сыну"
      set_meta_tags title: "Шары для любимого сына  от Шариковой феи",
                  description: "Любимый сын заслуживает всего самого лучшего, а самое лучшее - это подарить человеку настроение! Заказ шаров в Шариковой фее выручит вас.",
                  keywords: 'шары сыну',
                  reverse: true
    else
      set_meta_tags title: "Шары для любимого сына  от Шариковой феи",
                  description: "Воздушные шары #{params[:title]}",
                  reverse: true
    end
    @compositions = Composition.with_receivers(@person.title).availible.order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html  {redirect_to root_path, flash: {danger: 'Нет композиций!'} unless @compositions.any?}
      format.js if params[:page]
    end
  end

end
