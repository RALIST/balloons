class Delivery::ReceiversController < Delivery::DeliveryController

  def show
    if params[:id].to_i == 0
      @person = Receiver.find_by!(title: params[:id])
      redirect_to receiver_path(@person), status: 301
    else
      @person = Receiver.find(params[:id])
    end
    set_meta_tags title: "#{@person.title.capitalize}",
                  description: "Воздушные шары #{params[:title]}",
                  reverse: true
    @compositions = Composition.with_receivers(@person.title).availible.order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html  {redirect_to root_path, flash: {danger: 'Нет композиций!'} unless @compositions.any?}
      format.js if params[:page]
    end
  end

end
