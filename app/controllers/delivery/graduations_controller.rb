class Delivery::GraduationsController < Delivery::DeliveryController

  def kg
    set_meta_tags title: 'Оформление воздушными шарами для детского сада в Ижевске в компании Шариковая Фея',
                  description: "Закажите оформление шарами для детского сада в Ижевске по недорогой цене в компании Шариковая Фея"
  end

  def school
    set_meta_tags title: 'Оформление воздушными шарами на выпускной в Ижевске в компании Шариковая Фея',
                  description: "Украсьте выпускной воздушными шарами в Ижевске по недорогой цене в компании Шариковая Фея"
  end

  def univ
  end

  def index
  end

end
