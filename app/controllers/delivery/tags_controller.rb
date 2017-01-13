class Delivery::TagsController < Delivery::DeliveryController

  def index
    @tags = Tag.composition_tags
  end

end
