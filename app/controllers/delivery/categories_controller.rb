class Delivery::CategoriesController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Купить воздушные шары по тематике с доставкой в Ижевске | Шариковая фея', description: 'Воздушные шары с рисунком - это лучший способ порадовать ребенка! Персонажи любимых мультфильмов, цветы, смайлы и многое другое в ассортименте нашего магазина!'
    categories = Subcategory.joins(:products).where(products: {id: Product.availible_products})
    
    @categories = categories.distinct(:name).group('subcategories.id').select("subcategories.slug, subcategories.name, subcategories.id, subcategories.updated_at, COUNT(products.id) as total").order('total desc')

    fresh_when categories, last_modified: categories.maximum(:updated_at), public: true unless (current_user.try(:admin?) || Rails.env.development?)
  end

  def show
    @category = Subcategory.friendly.find(params[:id])
    products = @category.products

    @grouped_products = products.includes(:item, :type).availible_products.group_by{|s| s.type.name}

    set_meta_tags title: "Купить воздушные шары в тематике '#{@category.name.capitalize}' с доставкой в Ижевске | Шариковая фея",
                  description: "Воздушные шары из коллекции '#{@category.name.capitalize}' сделают ваш праздник незабываемым!"

    fresh_when products, last_modified: products.maximum(:updated_at), public: true unless current_user.try(:admin?)

  end
end
