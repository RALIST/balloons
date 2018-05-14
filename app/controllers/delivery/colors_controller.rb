class Delivery::ColorsController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Разноцветные воздушные шары с доставкой в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
                  description: 'Большой выбор воздушных шаров разных цветов на любой праздник от Шариковой феи'
    @colors = Color.includes(:image).select(:name, :slug, :id, :updated_at).all
  end

  def show
    @color = Color.friendly.find(params[:id])
    latex = Product.latex_in_compositions.includes(:item, :tone, :size, :type, :foil_form, :color).where(colors: { id: @color.id})
    foil = Product.foil_in_compositions.includes(:item, :tone, :size, :type, :foil_form, :color).where(colors: { id: @color.id })
    @items_in_collection = latex + foil
    set_meta_tags title: "#{@color.name.chomp('ый').capitalize + 'ые'} воздушные шары с гелием с доставкой в %{city}" % {city: t("cities.#{@city}.where")},
                  description: "#{@color.name.chomp('ый').capitalize + 'ые'} воздушные шары с гелием украсят любой праздник!"
  end
end
