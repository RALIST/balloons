class Delivery::PartnersController < Delivery::DeliveryController
  def index
    set_meta_tags title: 'Бизнес на воздушныхшарах без вложений',
                  description: 'Начните свой бизнес на воздушных шарах без вложений'
    @disable_header = true
  end
end
