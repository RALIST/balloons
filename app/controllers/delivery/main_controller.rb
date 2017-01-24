class Delivery::MainController < Delivery::DeliveryController
  def index
    @compositions = Composition.availible
  end

  def search
    unless params[:tag_name].blank?
      @compositions =  Composition.availible.with_tag(params[:tag_name])
      if @compositions.any?
        @compositions
      else
        redirect_to delivery_root_path
        flash[:info] = 'По запросу ' + params[:tag_name] + ' ничего не найдено!'
      end
    else
      redirect_to delivery_root_path
    end
  end
end
