class Delivery::ReceiversController < Delivery::DeliveryController

  def index
  
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

    @compositions = @person.compositions.availible.order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html
      format.js if params[:page]
    end
    set_meta_tags_for_receiver(@person)
  end
end
