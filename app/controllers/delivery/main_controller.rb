class Delivery::MainController < Delivery::DeliveryController
  def index
    @compositions = Composition.all
  end

  def index_with_tags
    tag = Tag.find_by(name: params[:tag_name])
    @compositions =  Composition.all.with_tag(tag)
  end
end
