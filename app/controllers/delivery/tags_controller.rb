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
		@menu_tags = Tag.composition_tags
	end

	def show
		begin
			@tag = Tag.friendly.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			if params[:id].to_i == 0 || params[:id] == '8 марта' || params[:id] == '14 февраля'
				@tag = Tag.find_by!(name: params[:id])
				redirect_to tag_path(@tag), status: 301
			else
				@tag = Tag.find(params[:id])
				redirect_to tag_path(@tag), status: 301
			end
		end
		@compositions = @tag.compositions.availible.order(:price).paginate(page: params[:page], per_page: 6)
		respond_to do |format|
			format.html { redirect_to root_path, flash: { danger: 'По запросу ' + @tag.name + ' ничего не найдено!' } unless @compositions.any? }
			format.js {render layout: false}
		end
		set_meta_tags_for_tag(@tag)
	end
end
