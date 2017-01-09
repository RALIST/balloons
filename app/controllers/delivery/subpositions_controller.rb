class Delivery::SubpositionsController < Delivery::DeliveryController

  def up_quantity
    @subposition = Subposition.find(params[:id])
    @subposition.update_attribute(:quantity, @subposition.quantity + 1)
    respond_to do |format|
      format.html{redirect_back(fallback_location: delivery_root_path)}
      format.js
    end
  end

  def down_quantity
    @subposition = Subposition.find(params[:id])
    if @subposition.quantity > 1
      @subposition.update_attribute(:quantity, @subposition.quantity - 1)
    else
      @subposition.destroy
    end
    respond_to do |format|
      format.html{redirect_back(fallback_location: delivery_root_path)}
      format.js
    end
  end

  def add_subposition
    item = Item.find(params[:item])
    @position = Position.find(params[:position_id])
    if @position.sub_exists?(item)
      @position.add_quantity_to_sub(item, params[:quantity])
    else
      @position.subpositions.create(item: item, quantity: params[:quantity])
    end 
    respond_to do |format|
      format.html{ redirect_back(fallback_location: delivery_root_path) }
      format.js
    end    
  end

end