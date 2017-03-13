class Delivery::BusinessController < Delivery::DeliveryController

  def index
     set_meta_tags title: 'Воздушные шары для бизнеса',
                  keywords: 'оформление магазина шарами, оформление входной группы шарами, оформление корпоратива шариками, оформление распродажи шариками'
    @disable_header = true
  end

end
