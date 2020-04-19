class Delivery::FormsController < Delivery::DeliveryController
  def index
    set_meta_tags title: "Воздушные шары любой формы с доставкой по Ижевску",
                  description: "Все формы воздушных шаров с гелием от Шариковой феи"
    @forms = FoilForm.joins(:products).distinct
  end

  def show
    @form = FoilForm.friendly.find(params[:id])
    products = @form.products.availible_products
    @grouped_products = products.includes(:item, :type).availible_products.group_by{|s| s.type.name}
    set_meta_tags title: "Воздушные шары #{@form.name} с гелием c доставкой в Ижевске",
                  description: "Воздушные шары с гелием в форме #{@form.name} с бесплатной доставкой по Ижевску"

    fresh_when products, last_modified: products.maximum(:updated_at), public: true
  end
end
