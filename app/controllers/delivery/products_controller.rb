class Delivery::ProductsController < Delivery::DeliveryController
  def index
    set_meta_tags title: "Гелиевые шары с доставкой в %{city} | Шариковая фея " % {city: t("cities.#{@city}.where")},
                  description: "Большой выбор гелиевых шаров с доставкой в %{city} от Шариковой феи наполнит ваш праздник атмосферой радости!" % {city: t("cities.#{@city}.where")},
                  keywords: 'гелиевые шары, воздушные шары с доставкой'


    @colors = Rails.cache.fetch('select_colors', expires_in: 1.day) {Color.joins(:products).where(products: {id: Product.availible_products.ids } ).distinct(:name).group('colors.id').select("colors.slug,colors.name, colors.updated_at, colors.id, COUNT(products.id) as total")}


    @categories = Rails.cache.fetch('select_categories', expires_in: 1.day) {Subcategory.joins(:products).where(products: {id: Product.availible_products.ids } ).distinct(:name).group('subcategories.id').select("subcategories.slug, subcategories.name, subcategories.id, subcategories.updated_at, COUNT(products.id) as total")}
  end
end
