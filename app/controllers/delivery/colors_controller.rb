class Delivery::ColorsController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Разноцветные воздушные шары с доставкой в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
                  description: 'Большой выбор воздушных шаров разных цветов на любой праздник от Шариковой феи'
    @colors = Color.all
    
  end

  def show
    @color = Color.friendly.find(params[:id])
    @items_in_collection = Product.includes(:item).where(items: {color_id: @color.id}).availible_products
    set_meta_tags title: " Заказать #{@color.name.chomp('ый') + 'ые'} воздушные шары с гелием с доставкой в %{city}" % {city: t("cities.#{@city}.where")},
                  description: "#{@color.name.chomp('ый').capitalize + 'ые'} воздушные шары с гелием украсят любой праздник!"
  end
end
