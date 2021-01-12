class Delivery::TagsController < Delivery::DeliveryController


	def index
		set_meta_tags title: 'Воздушные шары на праздник с доставкой в Ижевске | Шариковая фея',
									description: "Закажи оформление помещения воздушными гелиевыми шарами  для проведения торжества и важного события и получи дополнительные эмоции от прекрасной обстановки.",
									keywords: "шары на праздник,
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
		@grouped_compositions = Tag.distinct(:name).joins(:compositions).order(:id).group_by{|tag| tag.compositions.with_attached_image.distinct.limit(7) }

		fresh_when @grouped_compositions.keys, public: true
	end

	def show
		@tag = Tag.friendly.find(params[:id])
		@compositions = Composition.with_tag(@tag.name).order(:price).with_attached_image
  	set_meta_tags_for_tag(@tag)

		fresh_when @compositions, public: true
	end
end
