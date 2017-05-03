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

    case @tag.name
    when 'девичник'
      set_meta_tags title: "Заказать воздушные шары на девичник в Ижевске в компании Шариковая Фея",
                    description: "Оформить воздушными шарами девичник в Ижевске в компании Шариковая Фея",
                    reverse: true
    when 'вечеринка'
      set_meta_tags title: "Заказать оформление воздушными шарами на вечеринку в Ижевске в компании Шариковая Фея",
                    description: "Оформить вечеринку воздушными шарами в Ижевске в компании Шариковая Фея",
                    reverse: true
    when 'сюрприз'
      set_meta_tags title: "Заказать оформление воздушными шарами сюрприз в Ижевске в компании Шариковая Фея",
                    description: "Оформление воздушными шарами сюрприз в Ижевске в компании Шариковая Фея",
                    reverse: true
    when 'день рождения'
      set_meta_tags title: "Заказать оформление воздушными шарами на день рождения по выгодным ценам в Ижевске в компании Шариковая Фея",
                    description: "Оформить воздушными шарами день рождения мальчика или девочки, дешевые цены в каталоге компании Шариковая Фея",
                    reverse: true
    else
      set_meta_tags title: "Оформление воздушными шарами на #{@tag.name} в Ижевске в компании Шариковая Фея",
                    description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
                    reverse: true
    end

    @compositions =  Composition.availible.with_tag(@tag.name).order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html {redirect_to root_path, flash: {danger: 'По запросу ' + @tag.name + ' ничего не найдено!'} unless @compositions.any?}
      format.js if params[:page]
    end
  end

end
