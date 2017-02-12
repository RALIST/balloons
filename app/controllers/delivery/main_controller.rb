class Delivery::MainController < Delivery::DeliveryController
  def index
    # @page_title = 'Воздушные шары с доставкой, оформление праздников'
    # @page_description = 'Доставка воздушных шаров, оформление праздников'
    # @page_keywords
    set_meta_tags title: 'Воздушные шары с доставкой, лучшие композиции',
                  keywords: 'воздушные шары, гелиевые шары, гелиевые шарики, заказать воздушные шары, шарики с доставкой, доставка шариков, купить воздушные шары, купить шарики'
    @compositions = Composition.availible
    @composition  = Composition.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    set_meta_tags title: "#{params[:tag_name].capitalize}",
                  description: "Воздушные шары на #{params[:tag_name]}",
                  reverse: true,
                  keywords: "воздушные шары на #{params[:tag_name]}, заказать воздушные шары на #{params[:tag_name]}, шарики с доставкой на #{params[:tag_name]}, доставка шариков на #{params[:tag_name]}"
    unless params[:tag_name].blank?
      tag = Unicode::downcase(params[:tag_name]).strip
      @compositions =  Composition.availible.with_tag(tag)
      if @compositions.any?
        @compositions
      else
        redirect_to root_path
        flash[:info] = 'По запросу ' + params[:tag_name] + ' ничего не найдено!'
      end
    else
      redirect_to root_path
    end
  end

  def price
      set_meta_tags title: "Воздушные шары на #{params[:tag_name]} с доставкой!",
                    description: "Воздушные шары на #{params[:tag_name]}",
                    reverse: true,
                    keywords: "композиции из воздушных шары от #{params[:min]} до #{params[:max]}, заказать композиции из воздушных шары от #{params[:min]} до #{params[:max]}, шарики с доставкой от #{params[:min]} до #{params[:max]}, доставка шариков композиции из воздушных шары от #{params[:min]} до #{params[:max]}"
    @compositions = Composition.availible.price_range(params[:min].to_i - 100, params[:max].to_i + 100)
    if @compositions.any?
      @compositions
    else
      redirect_to root_path
      flash[:info] = 'В этом ценовом диапазоне ничего нет!'
    end
  end

  def for
    set_meta_tags title: "#{params[:q].capitalize}",
                  description: "Воздушные шары #{params[:q]}",
                  reverse: true,
                  keywords: "воздушные шары от #{params[:min]} до #{params[:max]} руб., гелиевые шары от #{params[:min]} до #{params[:max]} руб., гелиевые шарики от #{params[:min]} до #{params[:max]} руб., заказать воздушные шары от #{params[:min]} до #{params[:max]} руб., шарики с доставкой от #{params[:min]} до #{params[:max]} руб., доставка шариков от #{params[:min]} до #{params[:max]} руб., купить воздушные шары от #{params[:min]} до #{params[:max]} руб., купить шарики от #{params[:min]} до #{params[:max]} руб."
    @compositions = Composition.with_receivers(params[:q]).availible
    unless @compositions.any?
      flash[:alert] = 'Nothing'
    end
  end

  def thanks
    @order = Order.find(params[:order])
  end
end
