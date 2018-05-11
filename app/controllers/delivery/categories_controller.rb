class Delivery::CategoriesController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Коллекции воздушных шаров по тематике. Бесплатная доставка в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
                  description: 'Воздушные шары с рисунком - это лучший способ порадовать ребенка! Персонажи любимых мультфильмов, цветы, смайлы и многое другое в ассортименте нашего магазина!'
    @categories = Subcategory.availible.select(:id, :name, :slug, :updated_at)
  end

  def show
    @category = Subcategory.friendly.find(params[:id])
    products = @category.products
    @items_in_collection = products.availible_products.order(:name)
    set_meta_tags title: "#{@category.name.capitalize} - тематические воздушные шары | Шариковая фея",
                  description: "Воздушные шары из коллекции '#{@category.name.capitalize}' сделают ваш праздник незабываемым!"
  end
end
