class Delivery::BusinessController < Delivery::DeliveryController
  before_action :disable_sidebar

  def index
    set_meta_tags title: 'Оформление шарами открытия магазина',
                  description: 'Для привлечения внимания или в целях рекламной кампании вы можете обратиться в "Шариковую фею" для оформления шарами такого события, как открытие магазина.',
                  keywords: "оформление открытия магазина,
                           оформление шарами магазина,
                           оформление деловых презентаций,
                           оформление мероприятий шарами,
                           оформление входной группы,
                           печать на шарах #{@city},
                           печать на воздушных шарах,
                           печать на воздушных шарах #{@city}"
    @partners = Partner.all
    @outdoor = Image.where(style: 'вход')
    @indoor = Image.where(style: 'внутри')
    @print = Image.where(style: 'печать')
  end
end
