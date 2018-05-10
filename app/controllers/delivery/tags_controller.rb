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
		@tags = Tag.joins(:compositions).group(:id).order('COUNT (compositions.id) DESC')
	end

	def show
		@tag = Tag.friendly.find(params[:id])
		@compositions = Composition.with_tag(@tag.name).order(:price).paginate(page: params[:page], per_page: 6)
		respond_to do |format|
			format.html { redirect_to root_path, flash: { danger: 'По запросу ' + @tag.name + ' ничего не найдено!' } unless @compositions.any? }
			format.js {render layout: false}
		end
		set_meta_tags_for_tag(@tag)
	end
end
