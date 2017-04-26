class Delivery::TagsController < Delivery::DeliveryController

  def index
    @tags = Tag.composition_tags
  end

  def show
    @tag = Tag.find(params[:id])
    set_meta_tags title: "Заказать воздушные шары на #{@tag.name} в Ижевске в компании Шариковая Фея",
                  description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                  reverse: true
      @compositions =  Composition.availible.with_tag(@tag.name).order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'По запросу ' + params[:tag_name] + ' ничего не найдено!'} unless @compositions.any?}
      format.js {render 'index'} if params[:page]
    end
  end

end
