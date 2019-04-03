class Delivery::ReceiversController < Delivery::DeliveryController

  def index
    @compositions = Composition.availible.order(:price)
    fresh_when @compositions, last_modified: @compositions.maximum(:updated_at), public: true
    set_meta_tags 	title: 'Воздушные шары близким с доставкой в %{city} | Шариковая фея' % {city: t("cities.#{@city}.where")},
                   description: "Воздушные шары для любимых и близких людей"
  end


  def show
    begin
      @person = Receiver.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      if params[:id].to_i == 0 || params[:id] == '8 марта' || params[:id] == '14 февраля'
        @person = Receiver.find_by!(title: params[:id])
        redirect_to receiver_path(@person), status: 301
      else
        @person = Receiver.find(params[:id])
        redirect_to receiver_path(@person), status: 301
      end
    end
    set_meta_tags_for_receiver(@person)

    @compositions = @person.compositions.availible.order(:price)

    fresh_when @compositions, last_modified: @compositions.maximum(:updated_at), public: true

  end
end
