class Delivery::CompositionsController < Delivery::DeliveryController
  def index
    set_meta_tags title: 'Воздушные шары с доставкой, все композиции',
                  description: 'Доставка самых красивых воздушных шаров, оформление праздников, доставка по Ижевску бесплатно!',
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков'
    @compositions = Composition.availible.all.order(:price)
  end

  def show
    @comp = Composition.find(params[:id])
    @comp.update_attributes(views: @comp.views + 1)
    tags = @comp.tags.map(&:name)
    receivers = @comp.receivers.map(&:title)
    @tag = Tag.friendly.find(params[:tag_id]) if params[:tag_id]
    @receiver = Receiver.friendly.find(params[:receiver_id]) if params[:receiver_id]

    set_meta_tags title: "Композиция № #{@comp.id} из воздушных шаров | Шариковая фея",
                  reverse: true,
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков, воздушные шары с доставкой',
                  description: "Композиция из воздушных шаров на #{tags.join(', ')}, #{receivers.join(', ')}",
                  canonical: (composition_path(@comp) if @tag || @receiver)

    set_meta_tags og: {
      title: "Композиция № #{@comp.id} из воздушных шаров | Шариковая фея",
      type: 'article',
      url: composition_path(@comp),
      description: "Композиция из воздушных шаров на #{tags.join(', ')}, #{receivers.join(', ') if receivers}",
      image: 'https:' + @comp.img.url(:thumb),
      price: {
        amount: @comp.comp_price.round(0),
        currency: 'RUB'
      },
      site_name: 'Шариковая фея'
    }

  end

end
