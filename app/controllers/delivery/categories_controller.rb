class Delivery::CategoriesController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Воздушные шары любой тематики с доставкой в %{city} | Шариковая фея' % {city: t("citie.#{@city}.where")}, description: 'Воздушные шары с рисунком - это лучший способ порадовать ребенка! Персонажи любимых мультфильмов, цветы, смайлы и многое другое в ассортименте нашего магазина!'
    
    @categories = Rails.cache.fetch('select_categories', expires_in: 1.day) {Subcategory.joins(:products).where(products: {id: Product.availible_products.ids}).distinct(:name).group('subcategories.id').select("subcategories.slug, subcategories.name, subcategories.id, subcategories.updated_at, COUNT(products.id) as total")}
  end

  def show
    @category = Subcategory.friendly.find(params[:id])
    @items_in_collection = Rails.cache.fetch("category/#{@category.id}#{@category.products}") {@category.products.availible_products}
    set_meta_tags title: "Заказать воздушные шары '#{@category.name.capitalize}' с доставкой в %{city} | Шариковая фея" % {city: t("cities.#{@city}.where")},
                  description: "Воздушные шары из коллекции '#{@category.name.capitalize}' сделают ваш праздник незабываемым!"
    fresh_when @category.products, public: true
  end
end
