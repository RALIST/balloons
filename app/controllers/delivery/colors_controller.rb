class Delivery::ColorsController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Разноцветные воздушные шары с доставкой в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
                  description: 'Большой выбор воздушных шаров разных цветов на любой праздник от Шариковой феи'
    @colors = Rails.cache.fetch('select_colors', expires_in: 1.day) {Color.joins(:products).where.not(products: {price_with_helium: 0}).distinct(:name).group('colors.id').select("colors.slug,colors.name, colors.id, COUNT(products.id) as total")}
  end

  def show
    @color = Color.friendly.find(params[:id])
    latex = Product.latex_in_compositions.includes(:item, :tone, :size, :type, :foil_form, :color,:texture).where(colors: { id: @color.id})
    foil = Product.foil_in_compositions.includes(:item, :tone, :size, :type, :foil_form, :color,:texture).where(colors: { id: @color.id })
    @items_in_collection = latex + foil
    set_meta_tags title: " Заказать #{@color.name.chomp('ый') + 'ые'} воздушные шары с гелием с доставкой в %{city}" % {city: t("cities.#{@city}.where")},
                  description: "#{@color.name.chomp('ый').capitalize + 'ые'} воздушные шары с гелием украсят любой праздник!"
  end
end
