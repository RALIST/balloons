class Delivery::CategoriesController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Воздушные шары любой тематики с доставкой в %{city} | Шариковая фея' % {city: t("citie.#{@city}.where")}, description: 'Воздушные шары с рисунком - это лучший способ порадовать ребенка! Персонажи любимых мультфильмов, цветы, смайлы и многое другое в ассортименте нашего магазина!'
    categories = Subcategory.joins(:products).where(products: {id: Product.availible_products})
    
    @categories = categories.distinct(:name).group('subcategories.id').select("subcategories.slug, subcategories.name, subcategories.id, subcategories.updated_at, COUNT(products.id) as total").order('total desc')

    fresh_when categories, last_modified: categories.maximum(:updated_at), public: true unless current_user.try(:admin?)
  end

  def show
    @category = Subcategory.friendly.find(params[:id])
    products = @category.products

    @grouped_products = products.includes(:item, :type).availible_products.group_by{|s| s.type.name}

    set_meta_tags title: "Заказать воздушные шары '#{@category.name.capitalize}' с доставкой в %{city} | Шариковая фея" % {city: t("cities.#{@city}.where")},
                  description: "Воздушные шары из коллекции '#{@category.name.capitalize}' сделают ваш праздник незабываемым!"

    fresh_when products, last_modified: products.maximum(:updated_at), public: true unless current_user.try(:admin?)

  end
end
