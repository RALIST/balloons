class Delivery::TagsController < Delivery::DeliveryController

  def index
    @tags = Tag.composition_tags
  end

  def show
    if params[:id].to_i == 0 || params[:id] == '8 марта' || params[:id] == '14 февраля'
      @tag = Tag.find_by!(name: params[:id])
      redirect_to tag_path(@tag), status: 301
    else
      @tag = Tag.find(params[:id])
    end
    set_meta_tags title: "Оформление воздушными шарами на #{@tag.name} в Ижевске в компании Шариковая Фея",
                  description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                  reverse: true
      @compositions =  Composition.availible.with_tag(@tag.name).order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'По запросу ' + @tag.name + ' ничего не найдено!'} unless @compositions.any?}
      format.js if params[:page]
    end
  end

end
