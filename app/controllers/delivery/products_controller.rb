class Delivery::ProductsController < Delivery::DeliveryController
  def index
    set_meta_tags title: "Гелиевые шары с доставкой в %{city} | Шариковая фея " % {city: t("cities.#{@city}.where")},
                  description: "Большой выбор гелиевых шаров с доставкой в %{city} от Шариковой феи наполнит ваш праздник атмосферой радости!" % {city: t("cities.#{@city}.where")},
                  keywords: 'гелиевые шары, воздушные шары с доставкой'
    @colors = Color.select(:name, :slug, :id, :updated_at)
    @categories = Subcategory.joins(items: [:type, :sizes]).where('types.name = ? OR types.name = ?', 'латексные шары', 'фольгированные шары')
                              .select(:name, :slug, :id, :updated_at).distinct
  end
end
