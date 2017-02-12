class Delivery::CompositionsController < Delivery::DeliveryController
  def index
    set_meta_tags title: 'Воздушные шары с доставкой, все композиции',
                  description: 'Доставка самых красивых воздушных шаров, оформление праздников, доставка по Ижевску бесплатно!',
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков'
    @compositions = Composition.availible
  end

  def show
  @comp = Composition.find(params[:id])
  tags = @comp.tags.map(&:name)
  set_meta_tags title: "Композиция № #{@comp.id}",
                reverse: true,
                description: "Композиция из воздушных шаров на #{tags.join(', ')}"
  end

end
