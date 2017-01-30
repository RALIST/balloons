class Delivery::MainController < Delivery::DeliveryController
  def index
    @compositions = Composition.availible
    @composition  = Composition.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    unless params[:tag_name].blank?
      @compositions =  Composition.availible.with_tag(params[:tag_name])
      if @compositions.any?
        @compositions
      else
        redirect_to root_path
        flash[:info] = 'По запросу ' + params[:tag_name] + ' ничего не найдено!'
      end
    else
      redirect_to root_path
    end
  end
end
