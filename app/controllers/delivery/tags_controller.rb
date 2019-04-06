class Delivery::TagsController < Delivery::DeliveryController


	def index
		set_meta_tags 	title: 'Воздушные шары на праздник с доставкой в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
										description: "Закажи оформление помещения воздушными гелиевыми шарами  для проведения торжества и важного события и получи дополнительные эмоции от прекрасной обстановки.",
										keywords: "шары на праздник
																украсить праздник шарами,
																украсить праздник воздушными шарами,
																украшение праздника шарами,
																оформление праздников шарами,
																украшение праздников воздушными шарами,
																купить шары на праздник,
																заказать шары на праздник,
																оформление шарами детского праздника,
																украшение шарами детского праздника,
																детские праздники воздушными шарами,
																оформление праздников воздушными шарами,
																оформление детского праздника воздушными шарами"
		@compositions = Composition.availible.order(:price)
		fresh_when @compositions, last_modified: @compositions.maximum(:updated_at), public: true unless current_user.try(:admin?)
	end

	def show
		@tag = Tag.friendly.find(params[:id])
		@compositions = Composition.availible.with_tag(@tag.name).order(:price)
  set_meta_tags_for_tag(@tag)

		fresh_when @compositions, last_modified: @compositions.maximum(:updated_at), public: true unless current_user.try(:admin?)
	end
end
