class Delivery::ReceiversController < Delivery::DeliveryController

  def index
    set_meta_tags title: 'Воздушные шары близким с доставкой в Ижевске| Шариковая фея',
                  description: "Воздушные шары для любимых и близких людей"

    compositions = Composition.with_attached_image
		@grouped_compositions = Receiver.distinct(:title).joins(:compositions).order(:id).group_by{|tag| tag.compositions.with_attached_image.distinct.limit(7) }
    fresh_when compositions, public: true
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
    @compositions = @person.compositions.order(:price).with_attached_image

    fresh_when @compositions, public: true
  end
end
