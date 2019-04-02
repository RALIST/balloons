class Delivery::ColorsController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Разноцветные воздушные шары с доставкой в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
                  description: 'Большой выбор воздушных шаров разных цветов на любой праздник от Шариковой феи'
    @colors = Color.all
    fresh_when @colors, public: true
  end

  def show
    @color = Color.friendly.find(params[:id])
    products = @color.products
    @grouped_products = Rails.cache.fetch("color#{@color.id}_#{products}"){products.includes(:item, :type).where(items: {color_id: @color.id}).availible_products.group_by{|s| s.type.name}}
    set_meta_tags title: " Заказать #{@color.name.chomp('ый') + 'ые'} воздушные шары с гелием с доставкой в %{city}" % {city: t("cities.#{@city}.where")},
                  description: "#{@color.name.chomp('ый').capitalize + 'ые'} воздушные шары с гелием украсят любой праздник!"
    fresh_when products, public: true
  end
end
