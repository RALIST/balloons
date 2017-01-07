class Delivery::SubpositionsController < Delivery::DeliveryController

  def up_quantity
    @subposition = Subposition.find(params[:id])
    @subposition.update_attribute(:quantity, @subposition.quantity + 1)
    redirect_back(fallback_location: delivery_root_path)
  end

  def down_quantity
    @subposition = Subposition.find(params[:id])
    @subposition.update_attribute(:quantity, @subposition.quantity - 1)
    redirect_back(fallback_location: delivery_root_path)
  end

  def add_subposition
    position.subposition.create(sub_params)
  end

end