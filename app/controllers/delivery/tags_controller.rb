class Delivery::TagsController < Delivery::DeliveryController


	def index

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
		@compositions = Composition.availible.with_tag(@tag.name).order(:price).paginate(page: params[:page], per_page: 6)
		respond_to do |format|
			format.html { redirect_to root_path, flash: { danger: 'По запросу ' + @tag.name + ' ничего не найдено!' } unless @compositions.any? }
			format.js {render layout: false}
		end
		set_meta_tags_for_tag(@tag)
	end
end
